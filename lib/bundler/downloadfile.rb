module Bundler
  class Downloadfile
    
    def initialize(file_content, gem_path:)
      @gem_path = gem_path
      @file_content = file_content
    end
    
    def download(uri, to:'')
      directory = File.join(@gem_path, to)
      FileUtils.mkdir_p(directory)
      Download.file(uri, directory)
    end
    
    def call
      instance_eval(@file_content)
    end
  end
end
