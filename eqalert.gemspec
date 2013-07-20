# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "eqalert/version"

Gem::Specification.new do |s|
  s.name        = "eqalert"
  s.version     = Eqalert::VERSION
  s.authors     = ["Yoshihiro TAKAHARA"]
  s.email       = ["y.takahara@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This software is find frequency of earth quake in Japan.}
  s.description = %q{Find frequency of earth quake in Japan.}

  s.rubyforge_project = "eqalert"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
