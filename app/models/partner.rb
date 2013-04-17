class Partner < ActiveRecord::Base
  include HasUUID
  has_many :accounts

  validates :business_name,
            presence: true,
            uniqueness: true,
            length: { within: 1..22 },
            format: /\A[a-zA-Z0-9.<>(){}\[\]+&!$*;\-%_?:\#@~='" ^\\`|]+\Z/

  before_create :generate_credentials

  def add_account(attributes)
    accounts.create!(attributes) do |r|
      r.partner_id = id
    end
  end

  def find_account(uuid)
    accounts.where(uuid: uuid).first ||
      raise(ActiveRecord::RecordNotFound, "Couldn't find account with id #{uuid}")
  end

  private

  def generate_credentials
    generate_field :api_key
  end

  def generate_field(name)
    begin
      send "#{name}=", SecureRandom.hex
    end while self.class.exists?(name => send(name))
  end
end
