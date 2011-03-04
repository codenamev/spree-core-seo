map.resources :sitemap

map.product_list '/product_list.:format', :controller => :sitemap, :action => :product_list

map.namespace :admin do |admin|
  admin.resource :keywords_footer
  admin.resource :sitewide_seo
end
