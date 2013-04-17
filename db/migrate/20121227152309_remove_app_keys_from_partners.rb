class RemoveAppKeysFromPartners < ActiveRecord::Migration
  def self.up
    change_table :partners do |t|
      t.remove :app_id
      t.remove :app_secret
    end
  end

  def self.down
    change_table :partners do |t|
      t.string :app_id,     null: false
      t.string :app_secret, null: false
    end
  end
end
