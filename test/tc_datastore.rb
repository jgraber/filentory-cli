require 'test/unit'
require 'inventory/datastore'

class TestDatastore < Test::Unit::TestCase
  def test_initialisation_with_a_name 
    ds = Datastore.new("a name")
    
    assert_equal("a name", ds.name)
  end

  def test_can_set_a_type
    ds = Datastore.new("")
    ds.type= "DVD"

    assert_equal("DVD", ds.type)
  end

end