# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module SmartlingRails
  class SmartlingProcessor
    attr_accessor :my_smartling

    def initialize
      @my_smartling = Smartling::File.new(apiKey: SmartlingRails.api_key, projectId: SmartlingRails.project_id)
      SmartlingRails.print_msg "You are working with this remote file on smartling: #{ upload_file_path }", true
      SmartlingRails.print_msg "Smartling Ruby client #{ Smartling::VERSION }"
    end

    def file_statuses
      SmartlingRails.print_msg("Checking status for #{ supported_locales }", true)
      SmartlingRails.locales.each do | _language, codes |
        check_file_status(codes['smartling'])
      end
    end

    def supported_locales
      SmartlingRails.locales.map { |language, codes| language.to_s + ' ' + codes['smartling'] }
    end

    def check_file_status(language_code)
      res = @my_smartling.status(upload_file_path, locale: language_code)
      total_strings =  res['stringCount'].to_i
      completed_strings =  res['completedStringCount'].to_i
      file_complete = completed_strings >= total_strings
      SmartlingRails.print_msg "#{language_code} completed: #{ file_complete } (#{ completed_strings } / #{ total_strings })"
    rescue Exception => e
      puts e.message
    end

    def put_files
      SmartlingRails.print_msg('Uploading the english file to smartling to process:', true)
      upload_english_file
    end

    def upload_english_file
      SmartlingRails.print_msg("uploading #{ local_file_path_for_locale('en-us') } to #{ upload_file_path }")
      @my_smartling.upload(local_file_path_for_locale('en-us'), upload_file_path, 'YAML')
    end

    def local_file_path_for_locale(cb_locale)
      "config/locales/#{ cb_locale }.yml"
    end

    def upload_file_path
      "/files/[#{ SmartlingRails.configuration.rails_app_name || 'app' }]-[#{ current_branch }]-en-us.yml"
    end

    def files
      SmartlingRails.print_msg("Checking status for #{ supported_locales }", true)
      SmartlingRails.locales.each do | _language, locale_codes |
        fetch_fix_and_save_file_for_locale(locale_codes)
      end
    end

    def fetch_fix_and_save_file_for_locale(locale_codes)
      smartling_file = get_file_for_locale(locale_codes)
      smartling_file.fix_file_issues
      save_to_local_file(smartling_file.file_contents, locale_codes['custom'])
    end

    def get_file_for_locale(locale_codes)
      smartling_file = SmartlingFile.new('', locale_codes)
      SmartlingRails.print_msg "Downloading #{ locale_codes['smartling'] }:", true
      begin
        smartling_file.file_contents = @my_smartling.download(upload_file_path, locale: locale_codes['smartling'])
        SmartlingRails.print_msg 'file loaded...'
      rescue Exception => e
        SmartlingRails.print_msg e
      end
      smartling_file
    end

    def save_to_local_file(file_contents, cb_locale)
      File.open(local_file_path_for_locale(cb_locale), 'w') { |file| file.write(file_contents) }
    end

    def current_branch
      b = `git branch`.split("\n").delete_if { |i| i[0] != '*' }
      b.first.gsub('* ', '')
    end
  end
end
