# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: bundler-download 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bundler-download".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["AndyMaleh".freeze]
  s.date = "2020-09-21"
  s.description = "Bundler plugin for auto-downloading specified extra files after gem install".freeze
  s.email = "andy.am@gmail.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "LICENSE.txt",
    "README.md",
    "VERSION",
    "lib/bundler-download.rb",
    "lib/bundler-download/ext/download.rb",
    "lib/bundler-download/ext/glimmer/dsl/downloadfile/download_expression.rb",
    "lib/bundler/download.rb",
    "lib/bundler/downloadfile.rb",
    "plugins.rb"
  ]
  s.homepage = "http://github.com/AndyObtiva/bundler-download".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Bundler plugin for auto-downloading specified extra files after gem install".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<httparty>.freeze, ["~> 0.18.1"])
    s.add_runtime_dependency(%q<download>.freeze, ["~> 1.1.0"])
    s.add_runtime_dependency(%q<glimmer>.freeze, ["~> 1.0.0"])
    s.add_runtime_dependency(%q<tty-progressbar>.freeze, ["~> 0.17.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_development_dependency(%q<jeweler>.freeze, [">= 2.3.5"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<puts_debuggerer>.freeze, [">= 0"])
    s.add_development_dependency(%q<pessimize>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake-tui>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<httparty>.freeze, ["~> 0.18.1"])
    s.add_dependency(%q<download>.freeze, ["~> 1.1.0"])
    s.add_dependency(%q<glimmer>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<tty-progressbar>.freeze, ["~> 0.17.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<jeweler>.freeze, [">= 2.3.5"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<puts_debuggerer>.freeze, [">= 0"])
    s.add_dependency(%q<pessimize>.freeze, [">= 0"])
    s.add_dependency(%q<rake-tui>.freeze, [">= 0"])
  end
end

