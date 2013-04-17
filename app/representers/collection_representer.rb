class CollectionRepresenter
  include Enumerable

  def initialize(collection, env)
    @collection = collection
    @env = env
  end

  def each
    @collection.each do |element|
      yield BaseRepresenter.represent(element, @env)
    end
  end

  def as_json(*args)
    map { |e| e.to_hash(*args) }
  end
end
