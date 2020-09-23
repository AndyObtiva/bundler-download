# TODO

- `bundle download gem_name` processes Downloadfile for a specified gem only
- Designate some downloads as optional to avoid auto-installing upon `bundle install` (yet only with `bundle download --optional`)
- `bundle download clear` command to remove downloads (alias as `clean` too)
- `bundle download clear gem_name` command to remove downloads for a specified gem only (alias as `clean` too)
- Support `os` option for `download` DSL keyword in `Downloadfile`
- `bundle download --all-operating-systems` to download files for all OS'es
- Support groups (e.g. `:development`) just like Bundler's
