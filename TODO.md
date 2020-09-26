# TODO

You may contribute by implementing one of these TODO items and then submitting via a Pull Request.

- Avoid `require 'bundler/setup'` if running from API instead of Bundler Plugin
- Show "No downloaded files exist!" for `bundler download show` when a Downloadfile exists but downloads have not been made
- Support groups (e.g. `:development`) just like Bundler's
- Designate some downloads as optional to avoid auto-installing upon `bundle install` (yet only with `bundle download --optional`)
- `bundle download gem_name` processes Downloadfile for a specified gem only
- `bundle download clear gem_name` command to remove downloads for a specified gem only (alias as `clean` too)
- Ignore repetitions
- Support shortcut options like -k for --keep-existing, -a for --all-operating-systems, and -o for --optional
