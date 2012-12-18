# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano_rails_console'

Gem::Specification.new do |gem|
  gem.name          = "capistrano_rails_console"
  gem.version       = CapistranoRailsConsole::VERSION
  gem.authors       = ["Timo Schilling"]
  gem.email         = ["timo@schilling.io"]
  gem.description   = %q{Open a rails console the first app server.}
  gem.summary       = %q{Open a rails console the first app server.}
  gem.homepage      = "http://github.com/timoschilling/capistrano_rails_console"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "capistrano", "~> 2"

  gem.add_development_dependency "rake"
end
