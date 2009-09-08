# == Schema Information
#
# Table name: placements
#
#  id         :integer         not null, primary key
#  section    :text
#  ad_type    :text
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#  buy_id     :integer
#  quantity   :integer         default(1)
#  rate       :integer         default(0)
#

class Placement < ActiveRecord::Base
  belongs_to :buy
  validates_presence_of :section, :ad_type, :start_date, :end_date

  def display_name
    "#{section} (#{ad_type}) - #{start_date.to_s(:short)} to #{end_date.to_s(:short)}"
  end

  def cost
    rate * quantity
  end
end
