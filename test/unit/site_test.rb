# == Schema Information
#
# Table name: sites
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  should_have_many :buys
end
