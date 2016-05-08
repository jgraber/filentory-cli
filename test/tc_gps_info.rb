require File.expand_path '../test_helper.rb', __FILE__
require 'minitest/autorun'
require 'filentory/collector'
require 'filentory'
require 'mkfifo'

class TestGPSInfo < Minitest::Test

  def test_latitude_is_set
    result = fetch_gps_result()
    assert_equal(36.98276, result[0].metadata["exif.gps.latitude"])
  end

  def test_longitude_is_set
    result = fetch_gps_result()
    assert_equal(-110.11164666666667, result[0].metadata["exif.gps.longitude"])
  end

  def test_altitude_is_set
    result = fetch_gps_result()
    assert_equal(1709.4, result[0].metadata["exif.gps.altitude"])
  end

  private
  def fetch_gps_result()
    col = Collector.new
    result = col.collect(File.dirname(__FILE__)+"/integration/gps/")
    #puts "The result is: #{result}"
    assert_equal(1, result.length)
    result
  end
end