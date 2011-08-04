# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pyrois/version"

Gem::Specification.new do |s|
  s.name        = "pyrois"
  s.version     = Pyrois::VERSION
  s.authors     = ["Emmanuel Gomez"]
  s.email       = ["emmanuel.gomez@gmail.com"]
  s.homepage    = "http://github.com/emmanuel/pyrois"
  s.summary     = %q{Pyrois—Steed of Helios that pulls the sun (Solr) across the sky}
  s.description = %q{Pyrois is a client library for interacting with Apache Solr.}

  # s.rubyforge_project = "pyrois"

  s.add_runtime_dependency(%q<virtus>,        ["~> 0.0.7"])
  s.add_runtime_dependency(%q<rsolr>,         ["~> 1.0"])
  s.add_runtime_dependency(%q<activesupport>, ["~> 3"])

  s.add_development_dependency(%q<rake>,      ["~> 0.8.7"])
  s.add_development_dependency(%q<minitest>,  ["~> 2.3"])

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
