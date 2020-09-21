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
      file_size = content_length.to_f
      progress_total = (file_size / DOWNLOAD_CHUNK_SIZE).ceil
      bar = TTY::ProgressBar.new("Downloading :percent ( :eta ) [:bar]", total: progress_total)
      starting_bytes = 0
      File.open(file_path, 'wb') do |file_obj|
        until starting_bytes >= file_size
          Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
            ending_bytes = [starting_bytes + DOWNLOAD_CHUNK_SIZE, file_size].min
            ending_bytes = nil if ending_bytes == file_size
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
