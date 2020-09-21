module Bundler
  class Downloadfile
    include Glimmer
    
    def initialize(file_content)
      @file_content = file_content
    end
    
    def call
      instance_eval(@file_content)
    end
  end
end
