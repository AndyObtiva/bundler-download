# Change Log

## 1.1.0

- Add a post install message
- `bundle download clear` command to remove downloads (alias as `clean` too)
- Support `os` option for `download` DSL keyword in `Downloadfile`
- `bundle download --all-operating-systems` to download files for all OS'es
- `bundle download help` to show instructions (with `usage` as an alias)
- `bundle download list` lists downloads for every gem with a Downloadfile
- `bundle download show` shows downloaded files for every gem with size stats

## 1.0.0

- Initial bundler-download with gem-after-install-all hook and `download` command for gem `Downloadfile`
