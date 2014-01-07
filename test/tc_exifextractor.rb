require 'test/unit'
require 'pathname'
require 'inventory/exifextractor'

class TestExifExtractor < Test::Unit::TestCase

  def test_can_extract_metadata
    extractor = ExifExtractor.new
    metadata = extractor.metadata_for_file(File.dirname(__FILE__)+"/integration/data/image_with_exif_and_xmp_infos.jpg")
    
    assert_equal("Canon PowerShot S110", metadata["exif.model"])
    assert_equal("Johnny Graber", metadata["exif.artist"])
    assert_nil metadata["rdf.about"]
  end

end