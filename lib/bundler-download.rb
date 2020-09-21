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
require 'glimmer'
require 'httparty'
require 'tty-progressbar'

$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

Glimmer::Config.loop_max_count = 1_000_000
 
Glimmer::Config.excluded_keyword_checkers << lambda do |method_symbol, *args|
  method = method_symbol.to_s
  result = false
  result ||= method == 'load_iseq'
  result ||= method == 'handle'
  result ||= method == 'begin'
end


require 'bundler-download/ext/glimmer/dsl/downloadfile/download_expression'
require 'bundler-download/ext/download'
require 'bundler/downloadfile'

Bundler::Plugin.add_hook('after-install-all') do |dependencies|
  downloadfile = File.read('Downloadfile')
  Bundler::Downloadfile.new(downloadfile).call
end
