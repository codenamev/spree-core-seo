class SitemapController < Spree::BaseController
  def index
    @public_dir = "http://www.#{Spree::Config[:site_url]}/"
    respond_to do |format|
      format.html { @nav = _add_products_to_tax(_build_taxon_hash, true) }
      format.xml { render :layout => false, :xml => _build_xml(_add_products_to_tax(_build_taxon_hash, true), @public_dir) }
      format.text do
        @nav = _add_products_to_tax(_build_taxon_hash, true)
        render :layout => false
      end
    end
  end

  private
  def _build_xml(nav, public_dir)
    returning '' do |output|
      xml = Builder::XmlMarkup.new(:target => output, :indent => 2) 
      xml.instruct!  :xml, :version => "1.0", :encoding => "UTF-8"
      xml.urlset( :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9", 'xmlns:image' =>"http://www.google.com/schemas/sitemap-image/1.1", 'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance", 'xsi:schemaLocation' => "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" ) {
        xml.url {
          xml.loc public_dir
          xml.lastmod Date.today
          xml.changefreq 'weekly'
          xml.priority '1.0'
        }
        nav.each do |k, v| 
          xml.url {
            xml.loc public_dir + v['link']
            xml.lastmod v['updated'].xmlschema			  #change timestamp of last modified
            xml.changefreq 'weekly'
            xml.priority '0.8'
          } 
        end
        products = Hash.new
        products = _add_products(products)
        products.each do |k, v|
          xml.url {
            xml.loc public_dir + v['link']
            xml.lastmod v['updated'].xmlschema        #change timestamp of last modified
            xml.changefreq 'weekly'
            xml.priority '0.64'
            v['images'].each do |image|
              xml.image :image do
                xml.image :loc, root_url + image.attachment.url(:product)  
              end
            end
          }
        end
      }
    end
  end

  def _build_taxon_hash
    nav = Hash.new
    Taxon.find(:all).each do |taxon|
      tinfo = Hash.new
      tinfo['name'] = taxon.name
      tinfo['depth'] = taxon.permalink.split('/').size
      tinfo['link'] = 't/' + taxon.permalink 
      tinfo['updated'] = taxon.updated_at
      nav[taxon.permalink] = tinfo
    end
    nav
  end

  def _add_products_to_tax(nav, multiples_allowed)
    Product.active.find(:all).each do |product|
      pinfo = Hash.new
      pinfo['name'] = product.name
      pinfo['link'] = 'products/' + product.permalink	# primary
      pinfo['updated'] = product.updated_at

      nav[pinfo['link']] = pinfo				# store primary
      if multiples_allowed
        product.taxons.each do |taxon|
          pinfo['depth'] = taxon.permalink.split('/').size + 1
          taxon_link = taxon.permalink + 'p/' + product.permalink
          new_pinfo = pinfo.clone
          new_pinfo['link'] = taxon_link
          nav[taxon_link] = new_pinfo
        end
      else
      end
    end
    nav
  end

  # Build a product
  def _add_products(products, multiples_allowed = false)
    Product.active.find(:all).each do |product|
      pinfo = Hash.new
      pinfo['name'] = product.name
      pinfo['link'] = 'products/' + product.permalink # primary
      pinfo['updated'] = product.updated_at
      pinfo['images'] = product.images
      products[pinfo['link']] = pinfo       # store primary
      
      # cleaner sitemap xml without this
      if multiples_allowed
        product.taxons.each do |taxon|
          pinfo['depth'] = taxon.permalink.split('/').size + 1
          taxon_link = 't/' + taxon.permalink + 'p/' + product.permalink
          new_pinfo = pinfo.clone
          new_pinfo['link'] = taxon_link
          products[taxon_link] = new_pinfo
        end
      else
        #nothing
      end
    end
    products
  end
end
