require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'


module BaseRepresenter
  def self.included(mod)
    mod.instance_eval do
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
      include RouteHelpers

      attr_accessor :env
    end
  end

  def self.represent(resource, env)
    representer_name = "#{resource.class.to_s}Representer"
    return resource unless Object.const_defined?(representer_name)

    representer = representer_name.constantize
    resource.extend(representer)
    resource.env = env
    resource
  end

  def self.represent_collection(collection, env)
    CollectionRepresenter.new(collection, env)
  end
end
