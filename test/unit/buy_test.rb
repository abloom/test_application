# == Schema Information
#
# Table name: buys
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  plan_id    :integer
#  site_id    :integer
#

require 'test_helper'

class BuyTest < ActiveSupport::TestCase
  should_belong_to :plan
  should_belong_to :site
  should_have_many :placements
  should_validate_presence_of :placements
  should_validate_presence_of :site

  context "a buy factory" do
    setup do
      @buy = Factory.build(:buy)
    end

    should "create a valid object" do
      assert @buy.valid?
    end
    
    should "have a display_name" do
      assert_equal "Facebook - #{@buy.id}", @buy.display_name
    end
  end

  context "after_initialize with empty hash" do
    setup do
      @buy = Buy.new
    end
    
    should "build a site" do
      assert @buy.site
      assert @buy.site.new_record?
    end

    should "build a placement" do
      assert_false @buy.placements.empty?
      assert @buy.placements.first.new_record?
      assert @buy.initialize_placement
    end
  end
  
  context "after_initialize with full hash" do
    setup do
      @buy = Buy.new(:site => Factory(:site), :placements => [Factory(:placement)])
    end
    
    should "build a site" do
      assert_false @buy.site.new_record?
    end

    should "build a placement" do
      assert_false @buy.placements.first.new_record?
      assert_false @buy.initialize_placement
    end
  end
  
  test "placements nested attrs rejection" do
    buy = Buy.new(
      'placements_attributes' => { 
        0 => {
          'quantity' => '1',
          'rate' => '0',
          'section' => '',
          'ad_type' => ''
        }
      })
    assert buy.initialize_placement
    
    buy = Buy.new(
      'placements_attributes' => { 
        0 => {
          'quantity' => '1',
          'rate' => '0',
          'section' => 'asd',
          'ad_type' => 'dsa'
        }
      })
    assert_false buy.initialize_placement
  end

  test "a buy should have a cost equal to the sum of its placements' costs" do
    @placements = [mock(:cost => 30), mock(:cost => 20)]
    @buy = Buy.new
    @buy.expects(:placements).returns(@placements)

    assert_equal 50, @buy.cost
  end
end
