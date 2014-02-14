require 'oj'

class Datastore
  attr_accessor :name, :mediatype, :files

  def initialize(name)
    @name = name
    @files = Array.new
  end

  def to_json
    Oj::dump self, :indent => 2
  end
end
