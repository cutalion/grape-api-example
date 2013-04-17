class AddUuidToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :uuid, :string
  end

  def self.down
    remove_column :accounts, :uuid
  end
end
