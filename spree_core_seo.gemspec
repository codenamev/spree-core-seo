Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_core_seo'
  s.version     = '0.60.1'
  s.summary     = 'Spree extension that adds additional SEO tools'
  s.description = 'This Spree extension adds additional meta and title tag overrides, and includes a sitemap generator and keyword footer generator'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Mosaic Interactive'
  s.email             = 'developers@mosaicwebsite.com'
  s.homepage          = 'http://www.mosaicwebsite.com'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '>= 0.60.1')
end
