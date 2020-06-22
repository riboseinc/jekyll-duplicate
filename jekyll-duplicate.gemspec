# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = 'jekyll-duplicate'
  s.version       = '0.1.0'
  s.authors       = ['Ribose Inc.']
  s.email         = ['open.source@ribose.com']

  s.summary       = 'Jekyll plugin to render documents in additional ways'
  s.homepage      = 'https://github.com/riboseinc/jekyll-duplicate/'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|spec|features)/!) }

  s.add_runtime_dependency 'jekyll', '~> 4.0'
  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rubocop', '~> 0.50'

  s.require_paths = ["lib"]
end
