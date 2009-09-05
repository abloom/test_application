class AddColumnsToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :name, :string
    add_column :sites, :url, :string
    add_column :sites, :billing_contact, :string
  end

  def self.down
    remove_column :sites, :billing_contact
    remove_column :sites, :url
    remove_column :site, :name
  end
end
