require 'uri'
require 'net/http'

class Sender
  attr_accessor :url

  def initialize(url)
    @url = URI.parse(url)
    @failed = nil
  end

  def post(message)
  	begin
			params = {"data"=>message}
			response = Net::HTTP.post_form(@url, params)
			@failed = !response.code.to_s.start_with?("2")
		rescue => error_message
			response = Net::HTTPResponse.new "ERROR", "400", error_message
			@failed = true
		end	
			response
	end

	def failed?
		@failed
	end
end