require File.expand_path '../test_helper.rb', __FILE__
require 'minitest/autorun'
require 'filentory/collector'
require 'filentory'
require 'mkfifo'

class TestSpecialCases < Minitest::Test

  def test_pipes_are_ignored
  	cleanup()

  	File.mkfifo(File.dirname(__FILE__)+"/integration/special/pipe")

    col = Collector.new
    result = col.collect(File.dirname(__FILE__)+"/integration/special/")
    #puts "The result is: #{result}"
    assert_equal(2, result.length)
    assert_equal(".gitignore", result[0].name)
  end

  def test_exif_fields_are_filled_up
    col = Collector.new
    result = col.collect(File.dirname(__FILE__)+"/integration/special/")
    #puts "The result is: #{result}"

    assert_equal(2, result.length)
    assert_equal("exif.jpg", result[1].name)
    assert_equal(250, result[1].metadata['exif.artist'].length)
    assert_equal(250, result[1].metadata['dc.description'].length)


    assert_equal("Cannon", result[1].metadata['exif.make'])
    assert_equal("EOS 6D", result[1].metadata['exif.model'])
    assert_equal("2015-01-06T21:58:08+00:00", result[1].metadata['exif.date_time'])
    assert_equal("2015-01-06T09:11:18+00:00", result[1].metadata['exif.date_time_original'])
    assert_equal("Ipsach, Switzerland", result[1].metadata['Iptc4xmpCore.Location'])
  end

  def cleanup
  	if(File.exist?(File.dirname(__FILE__)+"/integration/special/pipe"))
  		FileUtils.rm(File.dirname(__FILE__)+"/integration/special/pipe")
  	end
  end

end