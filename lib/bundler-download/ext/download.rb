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

require 'net/http'

module Download
  class Object
    DOWNLOAD_CHUNK_SIZE = 1_048_576
    
    def start(hash={})
      set_multi(hash)

      File.delete(file_path) if File.exist?(file_path)
      
      head_response = HTTParty.head(url)
      uri = head_response.request.uri
      content_length = head_response.headers["content-length"]
      puts "Download file name: #{uri.path.split('/').last}"
      puts "Download file size: #{content_length}"
      puts "Download file path: #{file_path}"
      file_size = content_length.to_f
      progress_total = (file_size / DOWNLOAD_CHUNK_SIZE).ceil
      bar = TTY::ProgressBar.new("Downloading :percent ( :eta ) [:bar]", total: progress_total)
      starting_bytes = 0
      File.open(file_path, 'wb') do |file_obj|
        until starting_bytes >= file_size
          Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
            ending_bytes = [starting_bytes + DOWNLOAD_CHUNK_SIZE, file_size].min
            ending_bytes = nil if ending_bytes == file_size # this makes the request return remaining bytes only
            request = Net::HTTP::Get.new uri, 'Range' => "bytes=#{starting_bytes}-#{ending_bytes}"
            res = http.request request # Net::HTTPResponse object
            file_obj << res.body
            starting_bytes += DOWNLOAD_CHUNK_SIZE + 1
            bar.advance(1)
          end
        end
      end

      return file_path

    end 
  end
end
