require File.expand_path '../test_helper.rb', __FILE__
require 'minitest/autorun'
require 'filentory/collector'
require 'mkfifo'

class TestSpeicalCases < Minitest::Test

  def test_pipes_are_ignored
  	cleanup()

  	File.mkfifo(File.dirname(__FILE__)+"/integration/special/pipe")

	col = Collector.new
    result = col.collect(File.dirname(__FILE__)+"/integration/special/")
    #puts "The result is: #{result}"
    assert_equal(1, result.length)
    assert_equal(".gitignore", result[0].name)
  end

  def cleanup
  	if(File.exist?(File.dirname(__FILE__)+"/integration/special/pipe"))
  		FileUtils.rm(File.dirname(__FILE__)+"/integration/special/pipe")
  	end
  end

end