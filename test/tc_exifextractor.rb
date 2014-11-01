require File.expand_path '../test_helper.rb', __FILE__
require "minitest/autorun"
require 'pathname'
require 'filentory/exifextractor'

class TestExifExtractor < Minitest::Test

  def test_can_extract_metadata
    extractor = ExifExtractor.new
    metadata = extractor.metadata_for_file(File.dirname(__FILE__)+"/integration/data/image_with_exif_and_xmp_infos.jpg")
    
    assert_equal("Canon PowerShot S110", metadata["exif.model"])
    assert_equal("Johnny Graber", metadata["exif.artist"])
    assert_nil metadata["rdf.about"]
  end

  def test_can_handle_jpg
    assert(ExifExtractor.handles?(".jpg"), "ExifExtractor should handle .jpg")
  end
  
  def test_can_not_handle_avi
    assert(!ExifExtractor.handles?(".avi"), "ExifExtractor should responde false for .avi")
  end

end