# == Schema Information
#
# Table name: buys
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  plan_id    :integer
#  site_id    :integer
#

class Buy < ActiveRecord::Base
  belongs_to :plan
  belongs_to :site
  has_many :placements
  validates_presence_of :placements
  validates_presence_of :site
  
  accepts_nested_attributes_for :site
  accepts_nested_attributes_for :placements, :reject_if => lambda { |atrs|
    atrs['quantity'] == "1" && atrs["rate"] == "0" && atrs["section"].blank? && atrs["ad_type"].blank?
  }
  
  def display_name
    "#{site.name} - #{self.id}"
  end

  def cost
    placements.inject(0) do |n, p|
      n + p.cost
    end
  end
end
