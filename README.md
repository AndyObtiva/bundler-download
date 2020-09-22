# bundler-download - Bundler Plugin
[![Gem Version](https://badge.fury.io/rb/bundler-download.svg)](http://badge.fury.io/rb/bundler-download)

Bundler plugin for auto-downloading specified extra files via [`Downloadfile`](#downloadfile) after `bundle install`.

## How It Works

Gems declare the need for extra downloads upon install by Bundler via [`Downloadfile`](#downloadfile).

Apps can simply add those gems to Bundler `Gemfile` the standard way with no change. Afterwards, when running `bundle install`, bundle-download will automatically download extra files at the end.

If a Ruby Gem needs to depend on one of those gems, it can declare as a standard dependency in .gemspec

## Gem Instructions

Add `bundler-download` as a standard .gemspec dependency:

```ruby
s.add_dependency('bundler', [">= 2.1.4"])
```

Afterwards, ensure there is a [`Downloadfile`](#downloadfile) at the root directory of the gem that needs extra downloads, mentioning under .gemspec `files`:

```ruby
    s.files = [
    # ...
      "Downloadfile",
    # ...
    ]
```

### Downloadfile

A gem `Downloadfile` contains download links for files that need to be downloaded relative to the gem directory after install.

Example of `Downloadfile`:

```
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.gtk.linux.x86_64_0.4.0.202005172227.jar' # downloads into gem root directory
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.cocoa.macosx.x86_64_0.4.0.202005172227.jar', 
  to: 'cef' # downloads into 'cef' directory under the gem installation directory
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.win32.win32.x86_64_0.4.0.202005172227.jar',
  to: 'cef/windows' # downloads into 'cef/windows' directory under the gem installation directory
```

## App Instructions

Apps can depend on a gem with `Downloadfile` by adding `bundler-download` plugin and including the gem in `Gemfile` like it normally would:

```
plugin 'bundler-download'
gem 'some_gem_with_downloadfile'
```

Afterwards, run `bundle install` twice (the first time it installs the plugin and the second time it activates it):

```
bundle install
bundle install
```

You should see something like this:

```
$ bundle
Using array_include_methods 1.0.2
Using bundler 2.1.4
Using download 1.1.0
Using mime-types-data 3.2020.0512
Using mime-types 3.3.1
Using multi_xml 0.6.0
Using httparty 0.18.1
Using strings-ansi 0.1.0
Using tty-cursor 0.7.1
Using tty-screen 0.8.1
Using unicode-display_width 1.7.0
Using tty-progressbar 0.17.0
Using bundler-download 1.0.0
Using facets 3.1.0
Using glimmer 1.0.0
bundle-download plugin gem-after-install-all hook:
Processing /Users/User/.rvm/gems/ruby-2.7.1@tmp/gems/glimmer-1.0.0/Downloadfile
Download URL: https://equo-chromium-cef.ams3.digitaloceanspaces.com/rls/repository/plugins/com.make.chromium.cef.gtk.linux.x86_64_0.4.0.202005172227.jar
Download size: 57742279
Download path: /Users/User/.rvm/gems/ruby-2.7.1@tmp/gems/glimmer-1.0.0/com.make.chromium.cef.gtk.linux.x86_64_0.4.0.202005172227.jar
Downloading 100% (  0s ) [========================================================]
Download URL: https://equo-chromium-cef.ams3.digitaloceanspaces.com/rls/repository/plugins/com.make.chromium.cef.cocoa.macosx.x86_64_0.4.0.202005172227.jar
Download size: 54070695
Download path: /Users/User/.rvm/gems/ruby-2.7.1@tmp/gems/glimmer-1.0.0/cef/com.make.chromium.cef.cocoa.macosx.x86_64_0.4.0.202005172227.jar
Downloading 26% ( 59s ) [==============                                      ]
```

Subsequent runs of `bundle install` will keep existing downloads without overwriting them unless you use the [`bundle-download`](#bundler-download-command) command to manually redownload files again.

### Bundler Download Command

If you would like to redownload file from gem [`Downloadfile's`](#downloadfile) again, overwriting existing downloads, simply run:

`bundle download`

If you only want to download files if they didn't exist already, you could alternatively run:

`bundle download --keep-existing`

## Contributing to bundler-download
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

[MIT](LICENSE.txt)

Copyright (c) 2020 Andy Maleh.
