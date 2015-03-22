# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rakuten_api/version'

Gem::Specification.new do |spec|
  spec.name          = "rakuten_api"
  spec.version       = RakutenApi::VERSION
  spec.authors       = ["Masami Yonehara"]
  spec.email         = ["zeitdiebe@gmail.com"]
  spec.summary       = %q{Client for rakuten api}
  spec.description   = %q{Client for rakuten api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
