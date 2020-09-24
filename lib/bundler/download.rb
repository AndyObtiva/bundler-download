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

module Bundler
  class Download < Bundler::Plugin::API
    command "download"
  
    def exec(command, args)
      begin
        subcommand = extract_subcommand(args) || 'start'
        return puts("Invalid subcommand: #{subcommand} \nValid `bundle download` subcommands are: #{Bundler::Downloadfile::SUBCOMMANDS.join(' / ')}") unless Bundler::Downloadfile::SUBCOMMANDS.include?(subcommand)
        downloadfiles = Dir.glob(File.join(Gem.dir, 'gems', '**', 'Downloadfile')).to_a        
        loaded_gems = Gem.loaded_specs.keys
        downloadfiles = downloadfiles.select {|df| loaded_gems.detect {|gem| File.basename(File.dirname(df)).include?(gem)} }
        puts 'No gems were found with Downloadfile.' if downloadfiles.empty?
        downloadfiles.each do |downloadfile|
          bundler_downloadfile = Bundler::Downloadfile.new(
            downloadfile, 
            gem_path: File.dirname(downloadfile), 
            keep_existing: args.include?('--keep-existing'),
            all_operating_systems: args.include?('--all-operating-systems'),
          )
          bundler_downloadfile.send(subcommand)
        end
        true
      rescue => e
        puts e.full_message
        false
      end
    end
    
    private
    
    def extract_subcommand(args)
      args.detect {|arg| !arg.start_with?('-')}
    end
  end
end
