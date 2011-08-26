# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "convore/version"

Gem::Specification.new do |s|
  s.name        = "convore"
  s.version     = Convore::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Carlos Vilhena"]
  s.email       = ["carlosvilhena@gmail.com"]
  s.homepage    = "http://carvil.github.com"
  s.summary     = %q{A convore.com API implementation in ruby using EM}
  s.description = %q{}

  # s.rubyforge_project = "convore"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('eventmachine','0.12.10')
  s.add_dependency('rest-client','1.6.7')
  s.add_dependency('em-http-request','0.3.0')
end
