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
require 'smartling_rails'
namespace :smartling do
  desc 'check statuses'
  task :status do
    puts 'Attempting to get translation statuses:'
    SmartlingRails.processor.file_statuses
  end

  desc 'upload the en-us.yml file to smartling'
  task :put do
    puts 'Attempting to upload file to smartling:'
    SmartlingRails.processor.put_files
  end

  desc 'download the translations from smartling, fix and save'
  task :get do
    puts 'Attempting to download files from smartling:'
    SmartlingRails.processor.files
  end
end
