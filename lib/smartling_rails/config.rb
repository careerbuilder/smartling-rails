# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module SmartlingRails
  class Config
    attr_accessor :api_key, :project_id, :rails_app_name, :locales

    def initialize
      load_locales_from_yaml
      import_env_variables()
    end

    def load_locales_from_yaml
      config_file_path = 'config/smartling_rails.yml'
      throw "Localization File Missing '/config/smartling_rails.yml'" unless File.exist?(config_file_path)
      @locales = YAML::load_file(config_file_path)['locales']
    end

    def import_env_variables
      File.open(".env", "rb") do |f|
        f.each_line do |line|
          key_val = line.split("=")
          @api_key = key_val[1].strip if key_val[0] == 'SMARTLING_API_KEY'
          @project_id = key_val[1].strip if key_val[0] == 'SMARTLING_PROJECT_ID'
          @rails_app_name = key_val[1].strip if key_val[0] == 'SMARTLING_APP_NAME'
        end
      end unless !File.exist?('.env')
    end

  end
end
