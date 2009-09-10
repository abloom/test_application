require 'test_helper'

class EnumerableExtensionsTest < ActiveSupport::TestCase
  context "a hash" do
    setup do
      @hsh = {}
    end

    should "be empty" do
      assert @hsh.recursively_blank?
    end
    
    should "not be empty" do
      @hsh[:something] = "asd"
      assert_false @hsh.recursively_blank?
    end
    
    context "with multiple levels" do
      setup do
        @hsh = { :something => {} }
      end
      
      should "be empty" do
        assert @hsh.recursively_blank?
      end

      should "not be empty" do
        @hsh[:something] = { :else => "asd" }
        assert_false @hsh.recursively_blank?
      end
    end
  end
  
  context "an array" do
    setup do
      @arr = []
    end

    should "be empty" do
      assert @arr.recursively_blank?
    end
    
    should "not be empty" do
      @arr << "something"
      assert_false @arr.recursively_blank?
    end
    
    context "with multiple levels" do
      setup do
        @arr << []
      end
      
      should "be empty" do
        assert @arr.recursively_blank?
      end

      should "not be empty" do
        @arr << ["something"]
        assert_false @arr.recursively_blank?
      end
    end
  end
end
