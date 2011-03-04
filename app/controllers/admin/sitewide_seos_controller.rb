class Admin::SitewideSeosController < Admin::BaseController
  def show
  end

  def update
    seo_prefs = params[:preferences]
    Spree::Config.set(:keywords_footer => params[:preferences][:keywords_footer] )
    Spree::Config.set(:homepage_title => params[:preferences][:homepage_title] )
    Spree::Config.set(:homepage_meta_keywords => params[:preferences][:homepage_meta_keywords])
    Spree::Config.set(:homepage_meta_description => params[:preferences][:homepage_meta_description])

    respond_to do |format|
      format.html {
        redirect_to admin_sitewide_seo_path
      }
    end
  end
end
