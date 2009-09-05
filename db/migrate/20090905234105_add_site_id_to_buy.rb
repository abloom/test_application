class AddSiteIdToBuy < ActiveRecord::Migration
  def self.up
    remove_column :buys, :site_name
    add_column :buys, :site_id, :integer
  end

  def self.down
    add_column :buys, :site_name, :text
    remove_column :buys, :site_id
  end
end
