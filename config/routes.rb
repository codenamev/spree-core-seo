Rails.application.routes.draw do
  resources :sitemap

  match '/product_list.:format' => "sitemap#product_list"

  namespace :admin do |admin|
    resource :keywords_footer
    resource :sitewide_seo
  end
end
