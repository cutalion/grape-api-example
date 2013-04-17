class AddUuidToPartners < ActiveRecord::Migration
  def self.up
    add_column :partners, :uuid, :string
  end

  def self.down
    remove_column :partners, :uuid
  end
end
