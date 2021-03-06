require File.expand_path '../test_helper.rb', __FILE__
require 'minitest/autorun'
require 'pathname'
require 'filentory/videoextractor'

class TestVideoExtractor < Minitest::Test

  def test_can_extract_metadata
    extractor = VideoExtractor.new
    metadata = extractor.metadata_for_file(File.dirname(__FILE__)+"/integration/data/video.mov")
    
    assert_in_delta(2.18, metadata["duration"], 0.05)
    assert_equal("320x568", metadata["resolution"])
  end

  def test_can_handle_avi
    assert(VideoExtractor.handles?(".avi"), "VideoExtractor should handle .avi")
  end

  def test_can_not_handle_jpg
    assert(!VideoExtractor.handles?(".jpg"), "VideoExtractor should responde false for .jpg")
  end
end
