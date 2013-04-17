class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer :partner_id, null: false
      t.string  :name,  null: false
      t.string  :email, null: false
    end
  end

  def self.down
    drop_table :accounts
  end
end
