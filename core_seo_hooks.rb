class CoreSeoHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_configurations_menu do
    %(<%= configurations_menu_item(t('keywords_footer'), admin_keywords_footer_path, t('manage_keywords_footer')) %>)
  end
  insert_after :admin_configurations_menu do
    %(<%= configurations_menu_item(t('sitewide_seo'), admin_sitewide_seo_path, t('manage_sitewide_seo')) %>)
  end
  insert_before :admin_product_form_meta, 'admin/products/title_tag'
  insert_after :admin_inside_taxon_form, 'admin/taxons/seo_fields'

  insert_after :footer, 'shared/keywords_footer' 
end
