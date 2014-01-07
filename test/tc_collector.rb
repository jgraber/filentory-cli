require 'test/unit'
require 'pathname'
require 'inventory/collector'

class TestCollector < Test::Unit::TestCase

  def test_collector_finds_files
    col = Collector.new
    result = col.collect(File.dirname(__FILE__)+"/integration/data/")

    assert_equal(3, result.length)
    assert_equal("bf65dac6b214f362fc6a8b151c9f44668fed8460bbe8204f215e82332a295939", result[0].checksum)
    assert_equal(".", result[0].path)
  end

  def test_metadata_only_for_jpg
    col = Collector.new
    result = col.collect(File.dirname(__FILE__)+"/integration/data/")
    fileA = result[0]
    jpg = result[2]

    assert_equal("fileA.txt", fileA.name)
    assert_nil fileA.metadata

    assert_equal("image_with_exif_and_xmp_infos.jpg", jpg.name)
    assert_equal("Canon PowerShot S110", jpg.metadata["exif.model"])
  end

  def test_relative_path
    pn = Pathname.new("/test/integration/data/fileA")
    porig = Pathname.new("/test/integration/data")
    
    assert_equal(".", pn.relative_path_from(porig).dirname.to_s)
    assert_equal("fileA", pn.relative_path_from(porig).basename.to_s)
  end
end