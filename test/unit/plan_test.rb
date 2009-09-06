# == Schema Information
#
# Table name: plans
#
#  id              :integer         not null, primary key
#  advertiser_name :text
#  created_at      :datetime
#  updated_at      :datetime
#

require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  should_have_many :buys
  should_validate_presence_of :advertiser_name
  should_validate_presence_of :buys

  context "a plan factory" do
    setup do
      @plan = Factory.build(:plan)
    end

    should "build a valid instance" do
      assert @plan.valid?
    end
  end

  test "a plan should have a cost equal to the sum of its buys' costs" do
    Buy.any_instance.expects(:cost).returns(500).times(2)
    @plan = Plan.new
    @plan.expects(:buys).returns([Buy.new, Buy.new])

    assert_equal 1000, @plan.cost
  end
  
  test "all_for_site should only return Plans for a given site" do
    facebook = Factory(:site)
    google = Factory(:site, :url => "http://www.google.com", :name => "Google", :billing_contact => "Larry Page")
    msn = Factory(:site, :url => "http://www.msn.com", :name => "MSN", :billing_contact => "Bill Gates")
    
    f_buy_1 = Factory(:buy)
    f_buy_2 = Factory(:buy)
    
    g_buy_1 = Factory(:buy, :site => google)
    g_buy_2 = Factory(:buy, :site => google)
    
    f_plan = Factory(:plan, :buys => [f_buy_1, f_buy_2])
    g_plan = Factory(:plan, :buys => [g_buy_1, g_buy_2])
    
    assert_equal [f_plan], Plan.all_for_site(facebook)
    assert_equal [g_plan], Plan.all_for_site(google)
    
    m_buy_f = Factory(:buy, :site => msn)
    f_plan.buys << m_buy_f
    
    m_buy_g = Factory(:buy, :site => msn)
    g_plan.buys << m_buy_g
    
    plans = Plan.all_for_site(msn)
    assert plans.include?(f_plan)
    assert plans.include?(g_plan)
    assert_equal 2, plans.size
  end
end
