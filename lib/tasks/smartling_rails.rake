require 'smartling_rails'
namespace :smartling do 
  desc "check statuses"
  task :status do
    puts "Attempting to get translation statuses:"
    SmartlingRails.processor.get_file_statuses
  end

  desc "upload the en-us.yml file to smartling"
  task :put do
    puts "Attempting to upload file to smartling:"
    SmartlingRails.processor.put_files
  end

  desc "download the translations from smartling, fix and save"
  task :get do
    puts "Attempting to download files from smartling:"
    SmartlingRails.processor.get_files
  end
end
