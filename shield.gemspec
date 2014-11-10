# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shield/version'

Gem::Specification.new do |spec|
  spec.name          = "shield"
  spec.version       = Shield::VERSION
  spec.authors       = ["Rafael George"]
  spec.email         = ["george.rafael@gmail.com"]
  spec.summary       = %q{Policies implementation for Rails applications.}
  spec.description   = %q{Policies implementation for Rails applications.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
