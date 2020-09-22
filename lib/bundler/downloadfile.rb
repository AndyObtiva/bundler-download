module Bundler
  class Downloadfile
    
    def initialize(file_content, gem_path:, keep_existing:)
      @gem_path = gem_path
      @file_content = file_content
      @keep_existing = keep_existing
    end
    
    def download(uri, to:'')
      directory = File.join(@gem_path, to)
      FileUtils.mkdir_p(directory)
      options = {}
      options['--keep_existing'] = nil if @keep_existing
      ::Download.file(uri, directory, options)
    end
    
    def call
      instance_eval(@file_content)
    end
  end
end
