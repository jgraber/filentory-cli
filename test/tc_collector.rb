require 'test/unit'
require 'inventory/collector'

class TestCollector < Test::Unit::TestCase

  def test_collector_finds_files
    col = Collector.new
    result = col.collect(File.dirname(__FILE__)+"/integration/data/")

    assert_equal(2, result.length)
    assert_equal("bf65dac6b214f362fc6a8b151c9f44668fed8460bbe8204f215e82332a295939", result[0].checksum)
  end
end