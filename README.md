# bundler-download

Bundler plugin for auto-downloading specified extra files after gem install

## Instructions

Add `bundler-download` as a `Gemfile` dependency:

```ruby
gem 'bundler-download'
```

Afterwards, ensure there is a [`Downloadfile`](#downloadfile) in the root directory of your gem, mentioned under your `gemspec` files:

```ruby
    s.files = [
    # ...
      "Downloadfile",
    # ...
    ]
```

## Downloadfile

Just create `Downloadfile` in your project and fill it with download links for files to be downloaded into the gem directory after install.

Example of `Downloadfile`:

```
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.gtk.linux.x86_64_0.4.0.202005172227.jar' # downloads into gem root directory
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.cocoa.macosx.x86_64_0.4.0.202005172227.jar', 
  to: 'tmp' # downloads into vendor directory under the gem installation directory
download 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.win32.win32.x86_64_0.4.0.202005172227.jar',
  to: 'tmp/windows' # downloads into vendor/windows directory under the gem installation directory
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
