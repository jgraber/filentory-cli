require 'test/unit'
require 'pathname'
require 'inventory/videoextractor'

class TestVideoExtractor < Test::Unit::TestCase

  def test_can_extract_metadata
    extractor = VideoExtractor.new
    metadata = extractor.metadata_for_file(File.dirname(__FILE__)+"/integration/data/video.mov")

    assert_equal(2.18, metadata["duration"])
    assert_equal("568x320", metadata["resolution"])
  end

end