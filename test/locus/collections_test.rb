require 'test_helper'
require 'locus/collections'

class CollectionsTest < Minitest::Test
  context ".find_class" do
    should "properly find the class or return the collection class by default" do
      assert_equal Locus::Components, Locus::Collections.find_class("components")
      assert_equal Locus::Sites, Locus::Collections.find_class("sites")
      assert_equal Locus::Collection, Locus::Collections.find_class("foo")
    end
  end
end
