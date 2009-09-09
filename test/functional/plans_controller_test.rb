require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert assigns("plan")
    assert_response :success
  end
  
  test "create with valid params" do
    site = Factory(:site)
    
    assert_difference "Plan.count" do      
      post :create, :plan => { 
        :advertiser_name => "Ford", 
        :buys_attributes => {
          0 => {
            :site_id => site.id,
            :site_attributes => {
              :url => "http://www.google.com",
              :name => "Google",
              :billing_contact => "Lary Page"
            }, 
            :placement_ids => [Factory(:placement).id]
          }
        }
      }
    end
    
    plan = assigns("plan")
    assert plan
    assert_false plan.new_record?
    assert_equal site, plan.buys.first.site
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
    
    should "load a specific plan" do
      get :edit, :id => @plan.id
      
      assert_response :success
      assert_equal @plan, assigns("plan")
    end
    
    should "update with valid params" do
      buy1 = Factory(:buy)
      buy2 = Factory(:buy)
      put :update, :plan => { :advertiser_name => "Ford", :buy_ids => [buy1.id, buy2.id] }, :id => @plan.id

      plan = assigns("plan")
      assert plan
      assert_equal @plan.id, plan.id
      assert_equal "Ford", plan.advertiser_name
      assert_equal [buy1, buy2], plan.buys
      assert_redirected_to root_path
    end

    should "update with invalid params" do
      put :update, :plan => { :advertiser_name => "", :buy_ids => [] }, :id => @plan.id

      plan = assigns("plan")
      assert plan
      assert_equal @plan.id, plan.id
      assert_false plan.valid?
      assert_response :success
    end
  end  
end
