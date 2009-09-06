# == Schema Information
#
# Table name: plans
#
#  id              :integer         not null, primary key
#  advertiser_name :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Plan < ActiveRecord::Base
  has_many :buys
  validates_presence_of :advertiser_name

  named_scope :all_for_site, lambda { |site|
      {
        :conditions => ["buys.site_id = ?", site.id],
        :joins => :buys,
        :select => "DISTINCT plans.*"
      }
    }

  def cost
    buys.inject(0) do |n, b|
      n + b.cost
    end
  end
end
