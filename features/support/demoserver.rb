class DemoServer
  def call(env)
    req = Rack::Request.new(env)
    Rack::Response.new.finish do |res|
      res['Content-Type'] = 'text/plain'

      if req.path.start_with? "/ok"
      	res.status = 200
      	keys = []
      	req.params.each_key {|key| keys << key }
      	str = keys.join(" ")
        puts keys
      	res.write str
      else
      	res.status = 404
      	res.write "ERROR"
    	end
    end
  end
end