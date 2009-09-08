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
  
  accepts_nested_attributes_for :buys

  named_scope :all_for_site, lambda { |site|
      {
        :conditions => ["buys.site_id = ?", site.id],
        :joins => :buys,
        :select => "DISTINCT plans.*"
      }
    }

  def after_initialize
    buys.build if buys.empty?
  end

  def validate
    errors.add_on_empty :buys, "must contain at least one record"
  end

  def cost
    buys.inject(0) do |n, b|
      n + b.cost
    end
  end
end
