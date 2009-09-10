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
  
  context "a plan factory" do
    setup do
      @plan = Factory.build(:plan)
    end
  
    should "build a valid instance" do
      assert @plan.valid?
    end
    
    should "require at least one buy to be valid" do
      @plan.buys = []
      assert_false @plan.valid?
      assert @plan.errors.on(:buys)
    end
  end
  
  context "after_initialize with empty hash" do
    setup do
      @plan = Plan.new
    end
    
    should "build a buy" do
      assert_false @plan.buys.empty?
      assert @plan.buys.first.new_record?
      assert @plan.initialize_buy
    end
  end
  
  context "after_initialize with full hash" do
    setup do
      @plan = Plan.new(:buys => [Factory(:buy)])
    end
    
    should "build a buy" do
      assert_false @plan.buys.first.new_record?
      assert_false @plan.initialize_buy
    end
  end
  
  test "buys nested attrs rejection" do
    empty_hsh = {
      'buys_attributes' => {
        0 => {
          'placements_attributes' => { 
            0 => {
              'quantity' => '1',
              'rate' => '0',
              'section' => '',
              'ad_type' => ''
            }
          },
          "site_id" => "",
          "site_attributes" => {
            "name" => "",
            "url" => ""
          }
        }
      }
    }
    
    plan = Plan.new(empty_hsh)
    assert plan.initialize_buy
    
    placement_hsh = empty_hsh.dup
    placement_hsh["buys_attributes"][0]["placements_attributes"][0]["section"] = "a"
    plan = Plan.new(placement_hsh)
    assert_false plan.initialize_buy
    
    site_hsh = empty_hsh.dup
    site_hsh["buys_attributes"][0]["site_id"] = "1"
    plan = Plan.new(site_hsh)
    assert_false plan.initialize_buy
      
    site_hsh = empty_hsh.dup
    site_hsh["buys_attributes"][0]["site_attributes"]["name"] = "google"
    plan = Plan.new(site_hsh)
    assert_false plan.initialize_buy
  end
  
  test "a plan should have a cost equal to the sum of its buys' costs" do
    Buy.any_instance.expects(:cost).returns(500).times(2)
    @plan = Plan.new
    @plan.expects(:buys).returns([Buy.new, Buy.new])
  
    assert_equal 1000, @plan.cost
  end
  
  context "all_for_site" do
    setup do
      @facebook = Factory(:site)
      @google = Factory(:site, :url => "http://www.google.com", :name => "Google", :billing_contact => "Larry Page")
      @msn = Factory(:site, :url => "http://www.msn.com", :name => "MSN", :billing_contact => "Bill Gates")
  
      f_buy_1 = Factory(:buy, :site => @facebook)
      f_buy_2 = Factory(:buy, :site => @facebook)
  
      g_buy_1 = Factory(:buy, :site => @google)
      g_buy_2 = Factory(:buy, :site => @google)
  
      @f_plan = Factory(:plan, :buys => [f_buy_1, f_buy_2])
      @g_plan = Factory(:plan, :buys => [g_buy_1, g_buy_2])
  
      m_buy_f = Factory(:buy, :site => @msn)
      @f_plan.buys << m_buy_f
  
      m_buy_g = Factory(:buy, :site => @msn)
      @g_plan.buys << m_buy_g
    end
    
    should "only return plans for Google" do
      assert_equal [@g_plan], Plan.all_for_site(@google)
    end
    
    should "only return plans for Facebook" do
      assert_equal [@f_plan], Plan.all_for_site(@facebook)
    end
    
    should "only return plans for MSN" do
      plans = Plan.all_for_site(@msn)
      assert_equal [@f_plan, @g_plan], plans
    end
  end
end
