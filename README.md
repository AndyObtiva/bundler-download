# bundler-download - Bundler Plugin
[![Gem Version](https://badge.fury.io/rb/bundler-download.svg)](http://badge.fury.io/rb/bundler-download)

Bundler plugin for auto-downloading extra gem files (e.g. large file downloads) specified in [`Downloadfile`](#downloadfile) after `bundle install`.

## Background

The RubyGem ecosystem, famous for gems like Rails for web development, Devise for authentication, and Pundit for authorization, enables productivity via code reuse. As such, it is great for quickly adding libraries to your project to automate part of the work or reuse other people's solutions to solved problems.

That said, you would not want to package extremely large files, like the OpenAI GPT-3 175 billion parameter models, in a RubyGem.

Enter [bundler-download](https://rubygems.org/gems/bundler-download), a Bundler Plugin that enables downloading extra gem files after installing with with `bundle install` by declaring gem downloads in a [Downloadfile](#downloadfile)

## How It Works

Gems can add a [`Downloadfile`](#downloadfile) at the root to declare the need for extra downloads upon install by Bundler.

Apps can add those gems to Bundler `Gemfile` the standard way in addition to installing the [bundler-download](https://rubygems.org/gems/bundler-download) Bundler plugin. Afterwards, when running `bundle install`, bundle-download will automatically download extra files at the end.

If a Ruby Gem needs to depend on one of those gems, it can declare as a standard dependency in .gemspec

## Gem Instructions

Add [bundler-download](https://rubygems.org/gems/bundler-download) as a standard .gemspec dependency:

```ruby
s.add_dependency('bundler-download', [">= 1.1.0"])
```

Afterwards, ensure there is a [`Downloadfile`](#downloadfile) at the root directory of the gem, including in .gemspec `files`:

```ruby
    s.files = [
    # ...
      "Downloadfile",
    # ...
    ]
```

Finally, follow one of two options for having applications obtain downloads:
1. Advertise that apps must install `bundler-download` as a Bundler plugin as per the [App Bundler Plugin Instructions](#app-bundler-plugin-instructions) below.
2. Use the [API](#api) to automatically trigger downloads on first use of your gem features.

### Downloadfile

A gem `Downloadfile` contains `download` links for files that need to be downloaded relative to the gem directory after `bundle install`.

Downloadfile entries follow this format (keyword args are optional):

```
download url, to: gem_subdirectory, os: os
```

Example `Downloadfile`:

```
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.gtk.linux.x86_64_0.4.0.202005172227.jar' # downloads into gem root directory
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.cocoa.macosx.x86_64_0.4.0.202005172227.jar', 
  to: 'cef' # downloads into 'cef' directory under the gem installation directory
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.win32.win32.x86_64_0.4.0.202005172227.jar',
  to: 'cef/windows', os: 'windows' # downloads into 'cef/windows' directory under the gem installation directory in Windows OS only
```

The keyword `download` declares a file to download and takes the following arguments:
1. Download URL string
2. `to:` keyword arg: mentions a local download path relative to the gem installation directory (e.g. 'vendor' or 'lib/ai/data'). It automatically creates the path with all its subdirectories if it does not already exist. If left empty, then the file is downloaded to the gem directory root path.
3. `os:` keyword arg (value: `mac` / `windows` / `linux`): limits the operating system under which the download is made. It is `nil` by default, allowing the download to occur in all operating systems.

## App Bundler Plugin Instructions

An app can depend on a gem that has a `Downloadfile` by adding the `bundler-download` plugin first (or manually installing via `bundle plugin install bundler-download`) and then including the gem in `Gemfile` like it normally would:

```
plugin 'bundler-download'

gem 'some_gem_with_downloadfile'
```

Afterwards, run:

```
bundle install
```

(run one extra time if you don't have the `bundler-download` plugin installed yet since the first run would just install the plugin and subsequent runs would activate it)

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
Using bundler-download 1.1.0
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

After the initial download of files, running `bundle install` again will keep existing downloads without overwriting them unless you use the [`bundle-download`](#bundler-download-command) command to manually redownload files again.

### Bundler Download Command

If you would like to redownload files for all gems again, overwriting existing downloads, simply run:

```
bundle download
```

#### Options

##### --keep-existing

If you only want to download files if they did not exist already, you could run:

```
bundle download --keep-existing
```

Example printout:

```
Downloading /Users/User/.rvm/gems/ruby-2.7.1@bundler-download/gems/glimmer-cw-browser-chromium-1.0.0/Downloadfile
Download '/Users/User/.rvm/gems/ruby-2.7.1@bundler-download/gems/glimmer-cw-browser-chromium-1.0.0/vendor/jars/mac/com.make.chromium.cef.cocoa.macosx.x86_64_0.4.0.202005172227.jar' already exists! (run `bundle download` to redownload)
```

##### --all-operating-systems

If you want to download files for all operating systems (including ones other than the current platform), you could run:

```
bundle download --all-operating-systems
```

#### Subcommands

##### help (alias: usage)

Run the `help` subcommand (or usage) to bring up usage instructions:

```
bundle download help
``` 

Prints:

```
== bundler-download - Bundler Plugin - v1.1.0 ==
Commands/Subcommands:
  bundle download help   # Provide help by printing usage instructions
  bundle download usage  # (alias for help)
  bundle download start  # Start download
  bundle download        # (alias for start)
  bundle download clear  # Clear downloads by deleting them under all gems
  bundle download clean  # (alias for clear)
  bundle download list   # List downloads by printing Downloadfile content for all gems
  bundle download show   # Show downloaded files for all gems
```

##### clear (alias: clean)

Run the `clear` subcommand to clear downloads by deleting them under all gems:

```
bundle download clear
``` 

Example printout:

```
Clearing /Users/User/.rvm/gems/ruby-2.7.1@bundler-download/gems/glimmer-cw-browser-chromium-1.0.0/Downloadfile
```

##### list

Run the `list` subcommand to list downloads by printing Downloadfile content for all gems:

```
bundle download list
``` 

Example printout:

```
Listing /Users/User/.rvm/gems/ruby-2.7.1@bundler-download/gems/glimmer-cw-browser-chromium-1.0.0/Downloadfile
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.gtk.linux.x86_64_0.4.0.202005172227.jar',
  to: 'vendor/jars/linux', os: 'linux'
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.cocoa.macosx.x86_64_0.4.0.202005172227.jar', 
  to: 'vendor/jars/mac', os: 'mac'
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.win32.win32.x86_64_0.4.0.202005172227.jar',
  to: 'vendor/jars/windows', os: 'windows'
```

##### show

Run the `show` subcommand to show downloaded files for all gems:

```
bundle download show
``` 

Example printout:

```
Showing downloaded files for /Users/User/.rvm/gems/ruby-2.7.1@bundler-download/gems/glimmer-cw-browser-chromium-1.0.0/Downloadfile
54070695 /Users/User/.rvm/gems/ruby-2.7.1@bundler-download/gems/glimmer-cw-browser-chromium-1.0.0/vendor/jars/mac/com.make.chromium.cef.cocoa.macosx.x86_64_0.4.0.202005172227.jar
```

### API

Apps may choose to integrate with the [bundler-download](https://rubygems.org/gems/bundler-download) gem directly to trigger downloads instead of relying on the plugin.
This can be useful when wanting to trigger downloads only on first use while staying transparent should the gem features not be used.

To do so, simply include this Ruby code to trigger downloads:

```ruby
require 'bundler-download'
Bundler::Download.new.exec('download', [])
```

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
