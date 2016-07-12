# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'factory_media/github_utilities/version'

Gem::Specification.new do |spec|
  spec.name          = "factorymedia-github_utilities"
  spec.version       = FactoryMedia::GithubUtilities::VERSION
  spec.authors       = ["Joe Connor"]
  spec.email         = ["joe.connor@factorymedia.com"]

  spec.summary       = %q{Collection of utilities useful for interfacing with Github API.}
  spec.description   = %q{Collection of utilities useful for interfacing with Github API.}
  spec.homepage      = "https://github.com/factorymedia/github_utilities"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'github_api'
  spec.add_dependency 'activesupport', '>= 4.2.6'
end
