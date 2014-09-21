require 'minitest/autorun'
require 'filentory/datastore'

class TestDatastore < Minitest::Test
  def test_initialisation_with_a_name 
    ds = Datastore.new("a name")

    assert_equal("a name", ds.name)
  end

  def test_can_set_a_type
    ds = Datastore.new("")
    ds.mediatype= "DVD"

    assert_equal("DVD", ds.mediatype)
  end

  def test_can_add_array_of_files
    ds = Datastore.new("File")
    names = ["a", "b"]
    ds.files= Array.new (names)

    assert_equal(names, ds.files)
  end

  def test_can_add__files
    ds = Datastore.new("File")
    names = ["a", "b"]
    ds.files << "a"
    ds.files << "b"

    assert_equal(names, ds.files)
  end
end
