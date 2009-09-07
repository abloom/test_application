require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert assigns("site")
    assert_response :success
  end
  
  test "create with valid params" do
    assert_difference "Site.count" do
      post :create, :site => { :url => "www.google.com", :name => "Google", :billing_contact => "Lary Page" }
    end
    
    site = assigns("site")
    assert site
    assert_false site.new_record?
    assert_redirected_to root_path
  end
  
  test "create with invalid params" do
    assert_no_difference "Site.count" do
      post :create, :site => {}
    end
    
    site = assigns("site")
    assert site
    assert site.new_record?
    assert_response :success
  end
  
  context "a site factory" do
    setup do
      @site = Factory(:site)
    end
    
    should "index should show all sites" do
      get :index

      assert_response :success
      assert_equal [@site], assigns("sites")
    end
    
    should "show a specific site" do
      get :show, :id => @site.id
      
      assert_response :success
      assert_equal @site, assigns("site")
    end
  end
end
