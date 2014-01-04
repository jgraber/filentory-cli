class Datastore
  attr_accessor :name, :type, :files

  def initialize(name)
    @name = name
    @files = Array.new
  end
end
