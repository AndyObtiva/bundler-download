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
  class Downloadfile    
    attr_reader :file_content, :gem_path, :keep_existing
    
    SUPPORTED_OPERATING_SYSTEMS = %w[mac windows linux]    
    PLATFORM_OS = SUPPORTED_OPERATING_SYSTEMS.detect {|os| OS.send("#{os}?")}
    SUBCOMMANDS = %w[start clear clean help usage]
    
    def initialize(file_content, gem_path:, keep_existing: nil, all_operating_systems: nil)
      @file_content = file_content
      @gem_path = gem_path
      @keep_existing = keep_existing
      @all_operating_systems = all_operating_systems
      @downloads = []
      interpret
    end
    
    def download(uri, to:'', os: nil)
      directory = File.join(@gem_path, to)
      FileUtils.mkdir_p(directory)
      os = SUPPORTED_OPERATING_SYSTEMS.detect {|system| os.to_s.downcase == system}
      options = {os: os}
      options['--keep_existing'] = nil if @keep_existing
      @downloads << ::Download::Object.new(
        url: uri,
        path: directory,
        options: options
      )
    end
    
    def interpret
      instance_eval(@file_content)
    end
    
    def start
      @downloads.select {|download| @all_operating_systems || download.os.nil? || download.os == PLATFORM_OS }.each(&:start)
    end
    
    def clear
      @downloads.each(&:delete)
    end
    alias clean clear
    
    def help
      puts <<~MULTI_LINE_STRING
        == bundler-download - Bundler Plugin - v#{File.read(File.expand_path('../../../VERSION', __FILE__)).strip} ==
        Commands/Subcommands:
          bundle download help   # Provide help by printing usage instructions
          bundle download usage  # (alias for help)
          bundle download start  # Start download
          bundle download        # (alias for start)
          bundle download clear  # Clear downloads by deleting them under all gems
          bundle download clean  # (alias for clear)
      MULTI_LINE_STRING
    end
    alias usage help
  end
end
