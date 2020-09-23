module Bundler
  class Download < Bundler::Plugin::API
    command "download"
  
    def exec(command, args)
      begin
        subcommand = extract_subcommand(args) || 'start'
        return puts("Invalid subcommand: #{subcommand} \nValid `bundle download` subcommands are: #{Bundler::Downloadfile::SUBCOMMANDS.join(' / ')}") unless Bundler::Downloadfile::SUBCOMMANDS.include?(subcommand)
        downloadfiles = Dir.glob(File.join(Gem.dir, 'gems', '**', 'Downloadfile')).to_a
        puts 'No gems were found with Downloadfile.' if downloadfiles.empty?
        downloadfiles.each do |downloadfile|
          puts "Processing #{downloadfile}"
          bundler_downloadfile = Bundler::Downloadfile.new(File.read(downloadfile), gem_path: File.dirname(downloadfile), keep_existing: args.include?('--keep-existing'))
          bundler_downloadfile.send(subcommand)
        end
        true
      rescue => e
        puts e.full_message
        false
      end
    end
    
    private
    
    def extract_subcommand(args)
      args.detect {|arg| !arg.start_with?('-')}
    end
  end
end
