require 'test/unit'
require 'date'
require 'oj'
require 'filentory/fileentry'


class TestFileEntry < Test::Unit::TestCase

  def test_initialisation_with_a_path_and_a_name 
    fe = FileEntry.new("/media/","a name")

    assert_equal("a name", fe.name)
    assert_equal("/media/", fe.path)
  end

  def test_checksum_can_be_set
    fe = FileEntry.new("/media/","a name")
    fe.checksum = "1234"

    assert_equal("1234", fe.checksum)
  end

  def test_last_modification_can_be_set
    fe = FileEntry.new("/media/","a name")
    last = DateTime.iso8601("2014-01-04T21:06:04+01:00")

    fe.last_modified = last

    assert_equal("2014-01-04T21:06:04+01:00", fe.last_modified.strftime("%FT%T%:z"))
  end

  def test_json_stores_datestring
    fe = FileEntry.new("/media/","a name")
    fe.last_modified = DateTime.iso8601("2014-01-04T21:06:04+01:00")

    json = Oj::dump fe, :indent => 2

    assert_equal(json_compact.strip, json)
  end

  def test_to_s_is_readable
    fe = FileEntry.new("/media/","a name")
    fe.last_modified = DateTime.iso8601("2014-01-04T21:06:04+01:00")
    fe.size = 100

    assert_equal("/media/a name (100) - 2014-01-04T21:06:04+01:00",fe.to_s)
  end


  private
  def json_compact
<<-eos
{
  "^o":"FileEntry",
  "path":"/media/",
  "name":"a name",
  "last_modified":"2014-01-04T21:06:04+01:00"
}
eos
  end

end