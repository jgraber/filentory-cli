require 'test/unit'
require 'inventory/collector'

class TestCollector < Test::Unit::TestCase

  def test_collector_finds_files
    col = Collector.new
    result = col.collect(File.dirname(__FILE__)+"/integration/data/")

    assert_equal(2, result.length)
  end
end