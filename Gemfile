source "https://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

gem 'bundler', '>= 2.0.0', '< 3.0.0'
gem 'download', '>= 1.1.0', '< 2.0.0'
gem 'httparty', '>= 0.18.1', '< 2.0.0'
gem 'os', '>= 1.1.1', '< 2.0.0'
gem 'tty-progressbar', '>= 0.17.0', '< 2.0.0'

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "rspec", "~> 3.5.0"
  gem "jeweler", ">= 2.3.5"
  gem "simplecov", ">= 0"
  gem 'puts_debuggerer'
  gem 'pessimize'
  gem 'rake-tui', require: false
end

group :test do
  gem 'glimmer-dsl-swt'
  gem 'glimmer-cw-browser-chromium'
  gem 'bundler-download', path: '.'
  plugin 'bundler-download'
end

