require File.dirname(__FILE__) + '/../test_helper'

class CoreSeoExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_extension
    flunk
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(Rails.root), 'vendor', 'extensions', 'core_seo'), CoreSeoExtension.root
    assert_equal 'Core Seo', CoreSeoExtension.extension_name
  end
  
end
