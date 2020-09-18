# coding: utf-8
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kitchen-appbundle-updater/version"

Gem::Specification.new do |spec|
  spec.name          = "kitchen-appbundle-updater"
  spec.version       = KitchenAppbundleUpdater::VERSION
  spec.authors       = ["Chef Software"]
  spec.email         = ["oss@chef.io"]
  spec.description   = "A Test Kitchen Driver for Appbundle-updater"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/chef/kitchen-appbundle-updater"
  spec.license       = "Apache-2.0"

  s.files            = %w{LICENSE Gemfile Rakefile} + Dir.glob("*.gemspec") + Dir.glob("{lib,support}/**/*")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"

  spec.add_development_dependency "cane"
  spec.add_development_dependency "tailor"
  spec.add_development_dependency "countloc"
end
