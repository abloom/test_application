require 'test_helper'

class BuysHelperTest < ActionView::TestCase
  test "add_placement_path for existing buy" do
    buy = Factory(:buy)
    assert_equal "/buys/#{buy.id}/add_placement", add_placement_path(buy)
  end
  
  test "add_placement_path for new buy" do
    buy = Buy.new
    assert_equal "/buys/new/add_placement", add_placement_path(buy)
  end
end
