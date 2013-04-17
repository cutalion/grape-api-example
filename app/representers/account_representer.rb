module AccountRepresenter
  include BaseRepresenter

  property :uuid, from: :id
  property :name

  link :self do
    account_url(env['api.version'], uuid)
  end
end
