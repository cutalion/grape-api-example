class AddBusinessNameToPartners < ActiveRecord::Migration
  def self.up
    add_column :partners, :business_name, :string
  end

  def self.down
    remove_column :partners, :business_name
  end
end
