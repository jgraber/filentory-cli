# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filentory/version'

Gem::Specification.new do |gem|
  gem.name          = "filentory-cli"
  gem.version       = Filentory::VERSION
  gem.authors       = ["Johnny Graber"]
  gem.email         = ["jg@jgraber.ch"]
  gem.description   = "A tool to create an inventory of a storage medium"
  gem.summary       = "Filentory-cli is a first step to get order in a chaotic collection of storage medias."
  gem.homepage      = "https://github.com/jgraber/filentory-cli"
  gem.license       = 'Apache-2.0'

  gem.files         = `git ls-files *.rb`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('rdoc', '~> 6.1')
  gem.add_development_dependency('aruba', '~> 0.14')
  gem.add_development_dependency('rake', '~> 13.0')
  gem.add_development_dependency('fakeweb', '~> 1.3')
  gem.add_development_dependency('rack', '~> 2.2')
  gem.add_development_dependency('rack-test', '~> 1.1')
  gem.add_development_dependency('minitest', '~> 5.11')
  gem.add_development_dependency('mkfifo', '~> 0.1')
  gem.add_dependency('methadone', '~> 2.0')
  gem.add_dependency('oj', '~> 3.7')
  gem.add_dependency('json_spec', '~> 1.1.1')
  gem.add_dependency('exifr', '~> 1.3.0')
  gem.add_dependency('xmp', '~> 0.2.0')
  gem.add_dependency('streamio-ffmpeg', '~> 3.0')
  gem.add_development_dependency('simplecov', '~> 0.16')
end
