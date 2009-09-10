require 'test_helper'

class PlansHelperTest < ActionView::TestCase
  test "add_placement_path for existing buy" do
    @plan = Factory(:plan)
    assert_equal "/plans/#{@plan.buys.first.id}/add_placement?buy_index=0", add_placement_path(@plan.buys.first)
  end
  
  test "add_placement_path for new buy" do
    @plan = Plan.new(:buys => [Buy.new])
    assert_equal "/plans/new/add_placement?buy_index=0", add_placement_path(@plan.buys.first)
  end
  
  test "add_buy_path for existing plan" do
    @plan = Factory(:plan)
    assert_equal "/plans/#{@plan.buys.first.id}/add_buy", add_buy_path
  end
  
  test "add_buy_path for new plan" do
    @plan = Plan.new(:buys => [Buy.new])
    assert_equal "/plans/new/add_buy", add_buy_path
  end
end
