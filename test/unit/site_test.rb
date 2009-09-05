# == Schema Information
#
# Table name: sites
#
#  id              :integer         not null, primary key
#  created_at      :datetime
#  updated_at      :datetime
#  name            :string(255)
#  url             :string(255)
#  billing_contact :string(255)
#

require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  should_have_many :buys
  
  should_validate_presence_of :name
  should_validate_presence_of :url
  should_validate_presence_of :billing_contact
end
