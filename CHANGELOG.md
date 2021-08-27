# Change Log

## 1.4.0

- Support `Downloadfile` at the root of the app (not just gems)

## 1.3.1

- Improve instructions to help ensure correct and successful usage

## 1.3.0

- Setup Bundler default group only when using as an API to avoid loading :development/:test group gems into a production app
- Announce that download files are missing for `bundler download show` when a Downloadfile exists but downloads have not been made
- Document options (e.g. --keep-existing and --all-operating-systems) in `bundle download help`

## 1.2.0

- Get rid of httparty
- Only download files for Gemfile gems

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
