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

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('aruba')
  gem.add_development_dependency('rake', '~> 10.1.1')
  gem.add_dependency('methadone', '~> 1.3.1')
  gem.add_dependency('oj', '~> 2.5.3')
  gem.add_dependency('json_spec', '~> 1.1.1')
  gem.add_dependency('exifr', '~> 1.1.3')
  gem.add_dependency('xmp', '~> 0.2.0')
  gem.add_dependency('streamio-ffmpeg', '~> 1.0.0')
end
