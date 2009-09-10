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
  attr_accessor :initialize_buy
  
  has_many :buys
  validates_presence_of :advertiser_name
  
  # only accept nested attrs if the buy isnt an empty record
  accepts_nested_attributes_for :buys, :reject_if => lambda { |attrs|
    placements_blank = (attrs["placements_attributes"] || {"quantity" => "1", "rate" => "0"}).all? do |index, sub_attrs|
      sub_attrs['quantity'] == "1" && 
        sub_attrs["rate"] == "0" && 
        sub_attrs["section"].blank? && 
        sub_attrs["ad_type"].blank?
    end
    
    site_attributes_blank = (attrs["site_attributes"] || []).all?{ |k, v| v.blank? }
    site_blank = (attrs["site_id"].blank? && site_attributes_blank)
    placements_blank && site_blank
  }

  named_scope :all_for_site, lambda { |site|
      {
        :conditions => ["buys.site_id = ?", site.id],
        :joins => :buys,
        :select => "DISTINCT plans.*"
      }
    }

  def after_initialize
    if new_record?
      if self.buys.empty?
        self.buys.build
        self.initialize_buy = true
      end
    end
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
