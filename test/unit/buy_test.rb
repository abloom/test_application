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

  test "a buy should have a cost equal to the sum of its placements' costs" do
    @placements = [mock(:cost => 30), mock(:cost => 20)]
    @buy = Buy.new
    @buy.expects(:placements).returns(@placements)

    assert_equal 50, @buy.cost
  end
end
