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

class Site < ActiveRecord::Base
  has_many :buys
  
  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :billing_contact
end
