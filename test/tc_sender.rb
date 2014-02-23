require 'test/unit'
require 'uri'
require 'fakeweb'
require 'filentory/sender'

class TestSender < Test::Unit::TestCase

  def setup
  end

  def teardown
    FakeWeb.clean_registry
  end

  def test_initialisation_with_a_url 
    sender = Sender.new("http://localhost")

    assert_equal(URI.parse("http://localhost"), sender.url)
  end

  def test_can_send_message
    url = prepare("http://localhost/board", "send back")

    sender = Sender.new(url)
    sender.post("a small message.")

    request = FakeWeb.last_request 
    assert_equal("POST", request.method)
    assert_equal("data=a small message.".gsub(" ", "+"), request.body)
    assert_equal(false, sender.failed?)
  end

  def test_correct_error_when_page_is_missing
    url = prepare_fail("http://localhost/not_there", 404, "Not Found", "Missing page")

    sender = Sender.new(url)
    answer = sender.post("a small message.")
    
    assert_equal("404", answer.code)
    assert_equal("Not Found", answer.message)
  end

  def test_correct_error_when_unauthorized
    url = prepare_fail("http://localhost/auth_required", 401, "Unauthorized", "Missing page")

    sender = Sender.new(url)
    answer = sender.post("a small message.")
    
    assert_equal("401", answer.code)
    assert_equal("Unauthorized", answer.message)
  end

  def test_detects_error
    url = prepare_fail("http://localhost/auth_required", 401, "Unauthorized", "Missing page")

    sender = Sender.new(url)
    answer = sender.post("a small message.")

    assert_equal(true, sender.failed?)
  end

  def test_other_name_for_datafield
    url = prepare("http://localhost/board", "send back")

    sender = Sender.new(url)
    sender.datafield_name = "my_own_fieldname"
    sender.post("a small message.")

    request = FakeWeb.last_request 
    assert_equal("my_own_fieldname=a small message.".gsub(" ", "+"), request.body)
  end

  def test_add_other_fields
    url = prepare("http://localhost/board", "send back")

    sender = Sender.new(url)
    sender.additional_fields = {"a" => "JG"}
    sender.post("a small message.")

    request = FakeWeb.last_request 
    assert_equal("data=a small message.&a=JG".gsub(" ", "+"), request.body)
  end

  private
  def prepare(url, response)
    FakeWeb.register_uri(:post, url, :body => response)
    url
  end

  def prepare_fail(url, status_code, response, body)
    FakeWeb.register_uri(:post, url, :body => "Nothing to be found 'round here",
                          :status => [status_code.to_s, response])
    url
  end
end