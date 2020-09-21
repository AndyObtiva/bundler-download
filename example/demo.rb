require_relative '../lib/bundler-download'

class Downloadfile
  include Glimmer
  
  def initialize(file)
    file ||= 'http://dl.maketechnology.io/chromium-cef/rls/repository/plugins/com.make.chromium.cef.win32.win32.x86_64_0.4.0.202005172227.jar'
    download file,
      to: 'tmp/windows'
  end  
end

Downloadfile.new(ARGV.first)
  
   
