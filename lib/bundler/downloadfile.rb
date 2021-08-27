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
    attr_reader :file, :file_content, :gem_path, :keep_existing
    
    HELP = <<~MULTI_LINE_STRING
      Commands/Subcommands/Options:
        bundle download help                     # Provide help by printing usage instructions
        bundle download usage                    # (alias for help)
        bundle download start                    # Start downloads for current operating system
        bundle download                          # (alias for start)
        bundle download --all-operating-systems  # Download files for all operating systems
        bundle download --keep-existing          # Do not redownload already downloaded files
        bundle download clear                    # Clear downloads by deleting them under app/gems
        bundle download clean                    # (alias for clear)
        bundle download list                     # List downloads by printing Downloadfile content for app/gems
        bundle download show                     # Show downloaded files for app/gems
    MULTI_LINE_STRING

    SUPPORTED_OPERATING_SYSTEMS = %w[mac windows linux]
    PLATFORM_OS = SUPPORTED_OPERATING_SYSTEMS.detect {|os| OS.send("#{os}?")}
    SUBCOMMANDS = %w[start clear clean help usage list show]
    
    def initialize(file, gem_path:, keep_existing: nil, all_operating_systems: nil)
      @file = file
      @file_content = File.read(@file)
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
      puts "Downloading #{file}"
      @downloads.select {|download| @all_operating_systems || download.os.nil? || download.os == PLATFORM_OS }.each(&:start)
    end
    
    def clear
      puts "Clearing #{file}"
      @downloads.each(&:delete)
    end
    alias clean clear
    
    def help
      puts HELP
    end
    alias usage help
    
    def list
      puts "Listing #{file}"
      puts @file_content
    end
    
    def show
      puts "Showing downloaded files for #{file}"
      puts '- - -'
      missing_downloads = false
      missing_downloads_for_current_platform_os = false
      @downloads.each do |download|
        download_file_entry = download.file_path
        if File.exist?(download_file_entry)
          puts "Downloaded: #{File.size(download_file_entry)} #{download_file_entry}"
        else
          missing_downloads = true
          missing_downloads_for_current_platform_os = true if download.os == PLATFORM_OS
          puts "Not downloaded: #{download_file_entry}"
        end
      end
      message = ''
      if missing_downloads_for_current_platform_os
        message += "Downloads are missing for the current operating system (#{PLATFORM_OS}). \nRun `bundle download` to download missing files for current operating system (#{PLATFORM_OS}).\n"
      else
        message += "All downloads are present for current operating system (#{PLATFORM_OS})."
        message += " Optionally, run `bundle download --all-operating-systems` to download files for all operating systems.\n" if missing_downloads
      end
      puts message
      puts
    end
  end
end
