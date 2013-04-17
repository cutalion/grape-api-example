class Account < ActiveRecord::Base
  include HasUUID

  attr_accessible :name, :email

  validates :email, :name, :partner_id, presence: true
  validates :email, uniqueness: true
end
