# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kitchen-appbundle-updater/version'

Gem::Specification.new do |spec|
  spec.name          = 'kitchen-appbundle-updater'
  spec.version       = KitchenAppbundleUpdater::VERSION
  spec.authors       = ['Jay Mundrawala']
  spec.email         = ['jdmundrawala@gmail.com']
  spec.description   = %q{A Test Kitchen Driver for Appbundle-updater}
  spec.summary       = spec.description
  spec.homepage      = ''
  spec.license       = 'Apache 2.0'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  #spec.add_dependency 'test-kitchen', '~> 1.0.0.alpha.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'tailor'
  spec.add_development_dependency 'countloc'
end
