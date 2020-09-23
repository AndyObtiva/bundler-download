module Bundler
  class Downloadfile    
    attr_reader :file_content, :gem_path, :keep_existing
    
    SUPPORTED_OPERATING_SYSTEMS = %w[mac windows linux]    
    PLATFORM_OS = SUPPORTED_OPERATING_SYSTEMS.detect {|os| OS.send("#{os}?")}
    SUBCOMMANDS = %w[start clear clean]
    
    def initialize(file_content, gem_path:, keep_existing: nil)
      @file_content = file_content
      @gem_path = gem_path
      @keep_existing = keep_existing
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
      @downloads.select {|download| download.os.nil? || download.os == PLATFORM_OS }.each(&:start)
    end
    
    def clear
      @downloads.each(&:delete)
    end
    alias clean clear
  end
end
