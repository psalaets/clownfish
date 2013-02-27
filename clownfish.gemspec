# -*- encoding: utf-8 -*-
lib = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clownfish/version'

Gem::Specification.new do |gem|
  gem.name          = "clownfish"
  gem.version       = Clownfish::VERSION
  gem.authors       = ["Paul Salaets"]
  gem.email         = ["psalaets@gmail.com"]
  gem.summary       = "Anemone helper"
  gem.description   = "Anemone helper making common crawls easier to repeat."
  gem.homepage      = "https://github.com/psalaets/clownfish"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('anemone', '~> 0.7.2')
  gem.add_development_dependency('rspec', '~> 2.12')
end
