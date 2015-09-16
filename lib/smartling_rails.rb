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
require 'smartling'
require 'yaml'

Dir[File.dirname(__FILE__) + '/smartling_rails/**/*.rb'].each { |file| require file }

module SmartlingRails
  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= SmartlingRails::Config.new
  end

  def self.api_key
    configuration.api_key
  end

  def self.project_id
    configuration.project_id
  end

  def self.locales
    configuration.locales
  end

  def self.processor
    @processor ||= SmartlingRails::SmartlingProcessor.new
  end
end
