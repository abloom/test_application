require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert assigns("plan")
  end
  
  test "create with valid params" do
    post :create, :plan => { :advertiser_name => "Ford" }
    
    plan = assigns("plan")
    assert plan
    assert_false plan.new_record?
    assert_redirected_to root_path
  end
  
  test "create with invalid params" do
    post :create, :plan => {}
    
    plan = assigns("plan")
    assert plan
    assert plan.new_record?
    assert_response :success
  end
end
