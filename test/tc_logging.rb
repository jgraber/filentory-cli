require File.expand_path '../test_helper.rb', __FILE__
require 'minitest/autorun'
require 'filentory/collector'
require 'filentory'
require 'mkfifo'
require 'methadone'
require 'stringio'

class TestLogging < Minitest::Test
	def setup
		@pipe_path = File.dirname(__FILE__)+"/integration/special/pipe"
    @real_stderr = $stderr
    @real_stdout = $stdout
    $stderr = StringIO.new
    $stdout = StringIO.new
  end

  def teardown
    $stderr = @real_stderr
    $stdout = @real_stdout

    if(File.exist?(@pipe_path))
  		FileUtils.rm(@pipe_path)
  	end
  end

	def test_pipes_are_logged
		File.mkfifo(@pipe_path) unless File.exist?(@pipe_path)

  	col = Collector.new
  	#col.logger = Logger.new($stdout)
  	col.logger.level = Logger::DEBUG
    result = col.collect(File.dirname(__FILE__)+"/integration/special/")

    assert_equal(2, result.length)

    #assert_equal(Logger::DEBUG, col.logger.level)
    #puts "STDERR: #{$stderr.string}"
    #puts "STDOUT: #{$stdout.string}"
 		assert_includes($stdout.string, "skippking pipe")
	end

end