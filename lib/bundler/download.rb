module Bundler
  class Download < Bundler::Plugin::API
    command "download"
  
    def exec(command, args)
      begin
        downloadfiles = Dir.glob(File.join(Gem.dir, 'gems', '**', 'Downloadfile')).to_a
        puts 'No gems were found with Downloadfile.' if downloadfiles.empty?
        downloadfiles.each do |downloadfile|
          puts "Processing #{downloadfile}"
          Bundler::Downloadfile.new(File.read(downloadfile), gem_path: File.dirname(downloadfile), keep_existing: args.include?('--keep-existing')).call
        end
        true
      rescue => e
        puts e.full_message
        false
      end
    end
  end
end
