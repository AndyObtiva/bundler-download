# TODO

- `bundle download help` to show instructions (with `usage` as an alias)
- `bundle download list` lists downloads for every gem with a Downloadfile
- `bundle download show` shows downloaded files for every gem with size stats
- Support groups (e.g. `:development`) just like Bundler's
- Designate some downloads as optional to avoid auto-installing upon `bundle install` (yet only with `bundle download --optional`)
- `bundle download gem_name` processes Downloadfile for a specified gem only
- `bundle download clear gem_name` command to remove downloads for a specified gem only (alias as `clean` too)
- Ignore repetitions
- Support shortcut options like -k for --keep-existing, -a for --all-operating-systems, and -o for --optional
