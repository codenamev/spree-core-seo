# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class CoreSeoExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/core_seo"

  # Please use core_seo/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    Spree::BaseHelper.module_eval do
      # Override meta tags for homepage
      def meta_data_tags
        # if product index, then it's the homepage, so lets add the defaults
        if defined?(action_name) and action_name == "index"
          "".tap do |tags|
            if Spree::Config[:homepage_meta_keywords] and Spree::Config[:homepage_meta_keywords].present?
              tags << tag('meta', :name => 'keywords', :content => Spree::Config[:homepage_meta_keywords]) + "\n"
            end
            if Spree::Config[:homepage_meta_description] and Spree::Config[:homepage_meta_description].present?
              tags << tag('meta', :name => 'description', :content => Spree::Config[:homepage_meta_description]) + "\n" 
            end
          end
        else
          return unless self.respond_to?(:object) && object
          "".tap do |tags|
            if object.respond_to?(:meta_keywords) and object.meta_keywords.present?
              tags << tag('meta', :name => 'keywords', :content => object.meta_keywords) + "\n"
            end
            if object.respond_to?(:meta_description) and object.meta_description.present?
              tags << tag('meta', :name => 'description', :content => object.meta_description) + "\n"
            end
          end
        end
      end
    end

    ProductsController.class_eval do
      # This will override the entire title tag
      # Use accurate_title to keep Spree::Config[:site_name] in front of all titles
      def title
        if defined?(action_name) and action_name == "index"
          return Spree::Config[:homepage_title] if Spree::Config[:homepage_title].present?
        end
        if defined?(@product.title_tag)
          return @product.title_tag if !@product.title_tag.blank?
        end
        @product ? @product.name : nil
      end
    end

    TaxonsController.class_eval do
      # This will override the entire title tag
      # Use accurate_title to keep Spree::Config[:site_name] in front of all titles
      def title
        if defined?(@taxon.title_tag)
          return @taxon.title_tag if @taxon.title_tag.present?
        end
        @taxon ? @taxon.name : nil
      end
    end

  end
end
