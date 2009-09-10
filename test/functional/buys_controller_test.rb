require 'test_helper'

class BuysControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert assigns("buy")
    assert_response :success
  end
  
  test "create with valid params and premade site" do
    site = Factory(:site)
    
    assert_difference "Buy.count" do
      assert_no_difference "Site.count" do
        post :create, :buy => { :site_id => site.id, :placement_ids => [Factory(:placement).id] }
      end
    end
    
    buy = assigns("buy")
    assert buy
    assert_false buy.new_record?
    assert_redirected_to root_path
  end
  
  test "create with valid params and new site" do
    assert_difference "Buy.count" do
      assert_difference "Site.count" do
        post :create, :buy => { 
          :site_attributes => {
            :url => "http://www.google.com",
            :name => "Google",
            :billing_contact => "Lary Page"
          }, 
          :placement_ids => [Factory(:placement).id] }
      end
    end
    
    buy = assigns("buy")
    assert buy
    assert_false buy.new_record?
    assert_redirected_to root_path
  end
  
  test "create with valid params and new site and premade site chooses premade" do
    site = Factory(:site)
    
    assert_difference "Buy.count" do
      assert_no_difference "Site.count" do
        post :create, :buy => {
          :site_id => site.id,
          :site_attributes => {
            :url => "http://www.google.com",
            :name => "Google",
            :billing_contact => "Lary Page"
          }, 
          :placement_ids => [Factory(:placement).id] }
      end
    end
    
    buy = assigns("buy")
    assert buy
    assert_false buy.new_record?
    assert_redirected_to root_path
  end
  
  test "create with invalid params" do
    assert_no_difference "Plan.count" do
      post :create, :buy => {}
    end
    
    buy = assigns("buy")
    assert buy
    assert buy.new_record?
    assert_response :success
  end
  
  context "a buy factory" do
    setup do
      @buy = Factory(:buy)
    end
    
    should "index should show all buy" do
      get :index

      assert_response :success
      assert_equal [@buy], assigns("buys")
    end
    
    should "show a specific buy" do
      get :show, :id => @buy.id
      
      assert_response :success
      assert_equal @buy, assigns("buy")
    end
    
    should "edit a specific buy" do
      get :edit, :id => @buy.id
      
      assert_response :success
      assert_equal @buy, assigns("buy")
    end
    
    should "update a specific buy" do
      site2 = Factory(:site)
      put :update, :id => @buy.id, :buy => { :site_id => site2.id }
      
      buy = assigns("buy")
      assert_equal site2, buy.site
      assert_redirected_to root_path
    end
    
    should "fail to update a specific buy with invalid params" do
      site2 = Factory(:site)
      put :update, :id => @buy.id, :buy => { :site_id => nil }
      
      buy = assigns("buy")
      assert_not_equal site2, buy.site
      assert_response :success
    end
    
    should "add a placement to the buy" do
      post :add_placement, :id => @buy.id, :buy => @buy.attributes
      assert_response :success
      
      buy = assigns('buy')
      assert_equal @buy.placements.size + 1, buy.placements.size
    end
  end
end
