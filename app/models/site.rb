# == Schema Information
#
# Table name: sites
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Site < ActiveRecord::Base
  has_many :buys
end
