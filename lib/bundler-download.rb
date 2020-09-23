# Copyright (c) 2020 Andy Maleh
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'bundler'
require 'download'
require 'fileutils'
require 'httparty'
require 'os'
require 'tty-progressbar'

$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

require 'bundler-download/ext/download'
require 'bundler/downloadfile'
require 'bundler/download'

Bundler::Plugin.add_hook(Bundler::Plugin::Events::GEM_AFTER_INSTALL_ALL) do |dependencies|
  puts 'bundle-download plugin gem-after-install-all hook (checking gems for Downloadfile):'
  Bundler::Download.new.exec('download', ['--keep-existing'])
end
