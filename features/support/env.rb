require 'aruba/cucumber'
require 'methadone/cucumber'
require "json_spec/cucumber"
require 'fakeweb'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s

	FakeWeb.register_uri(:post, "http://jgraber.ch/ok", :body => "OK")
	FakeWeb.register_uri(:post, "http://jgraber.ch/auth_needed", 
	    										:body => "Nothing to be found 'round here",
                          :status => [401, "Unauthorized"])
end

After do
 	FakeWeb.clean_registry

  ENV['RUBYLIB'] = @original_rubylib
end
