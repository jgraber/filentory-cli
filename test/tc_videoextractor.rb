require 'minitest/autorun'
require 'pathname'
require 'filentory/videoextractor'

class TestVideoExtractor < Minitest::Test

  def test_can_extract_metadata
    extractor = VideoExtractor.new
    metadata = extractor.metadata_for_file(File.dirname(__FILE__)+"/integration/data/video.mov")

    assert_equal(2.18, metadata["duration"])
    assert_equal("568x320", metadata["resolution"])
  end

  def test_can_handle_avi
    assert(VideoExtractor.handles?(".avi"), "VideoExtractor should handle .avi")
  end

  def test_can_not_handle_jpg
    assert(!VideoExtractor.handles?(".jpg"), "VideoExtractor should responde false for .jpg")
  end
end
