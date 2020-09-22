# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "bundler-download"
  gem.homepage = "http://github.com/AndyObtiva/bundler-download"
  gem.license = "MIT"
  gem.summary = %Q{Bundler plugin for auto-downloading specified extra files after gem install}
  gem.description = %Q{Bundler plugin for auto-downloading specified extra files after gem install}
  gem.email = "andy.am@gmail.com"
  gem.authors = ["AndyMaleh"]
  gem.files = Dir['bundler-download.gemspec', 'README.md', 'LICENSE.txt', 'VERSION', 'CHANGELOG.md', 'plugins.rb', 'lib/**/*', 'bin/**/*']
  gem.executables = ['bundler-download']
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bundler-download #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
