require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert assigns("plan")
    assert_response :success
  end
  
  test "create with valid params" do
    assert_difference "Plan.count" do
      post :create, :plan => { :advertiser_name => "Ford" }
    end
    
    plan = assigns("plan")
    assert plan
    assert_false plan.new_record?
    assert_redirected_to root_path
  end
  
  test "create with invalid params" do
    assert_no_difference "Plan.count" do
      post :create, :plan => {}
    end
    
    plan = assigns("plan")
    assert plan
    assert plan.new_record?
    assert_response :success
  end
  
  context "a plan factory" do
    setup do
      @plan = Factory(:plan)
    end
    
    should "index should show all plans" do
      get :index

      assert_response :success
      assert_equal [@plan], assigns("plans")
    end
    
    should "show a specific plan" do
      get :show, :id => @plan.id
      
      assert_response :success
      assert_equal @plan, assigns("plan")
    end
    
    should "return a 404 if an unknown plan is shown" do
      @request.remote_addr = "123.456.789.012"
      get :show, :id => "madeup"
      
      assert_response 404
    end
    
    should "load a specific plan" do
      get :edit, :id => @plan.id
      
      assert_response :success
      assert_equal @plan, assigns("plan")
    end
    
    should "return a 404 if unknown plan is edited" do
      @request.remote_addr = "123.456.789.012"
      get :show, :id => "madeup"
      
      assert_response 404
    end
  end  
end
