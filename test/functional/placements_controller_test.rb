require 'test_helper'

class PlacementsControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert assigns("placement")
    assert_response :success
  end
  
  test "create with valid params" do
    assert_difference "Placement.count" do
      post :create, :placement => { 
        :section => "footer",
        :ad_type => "flash banner",
        :start_date => "2009-12-01",
        :end_date => "2009-12-02" }
    end
    
    placement = assigns("placement")
    assert placement
    assert_false placement.new_record?
    assert_redirected_to root_path
  end
  
  test "create with invalid params" do
    assert_no_difference "Plan.count" do
      post :create, :placement => {}
    end
    
    placement = assigns("placement")
    assert placement
    assert placement.new_record?
    assert_response :success
  end
end
