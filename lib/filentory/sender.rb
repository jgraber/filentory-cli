require 'uri'
require 'net/http'

class Sender
  attr_accessor :url, :datafield_name, :additional_fields

  def initialize(url)
    @url = URI.parse(url)
    @failed = nil
    @datafield_name = "data"
  end

  def post(message)
  	begin
			params = {@datafield_name => message}
			if not @additional_fields.nil?
				params.merge!(@additional_fields)
			end
			http = Net::HTTP.new(@url.host, @url.port)
			http.read_timeout = 600
			
			request = Net::HTTP::Post.new(@url.request_uri)
			request.set_form_data(params)

			response = http.request(request)

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