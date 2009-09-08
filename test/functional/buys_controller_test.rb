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
end
