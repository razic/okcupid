# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'okcupid/version'

Gem::Specification.new do |spec|
  spec.name          = "okcupid"
  spec.version       = OkCupid::VERSION
  spec.authors       = ["Zachary Adam Kaplan"]
  spec.email         = ["razic@viralkitty.com"]
  spec.summary       = %q{An OkCupid API and CLI written in Ruby}
  spec.homepage      = "https://github.com/razic/okcupid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.13.1"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
end
