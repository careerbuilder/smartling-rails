require 'smartling'
Dir[File.dirname(__FILE__) + '/smartling_rails/**/*.rb'].each { |file| require file }

module SmartlingRails

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= SmartlingRails::Config.new
  end

  def self.api_key
    @configuration.api_key
  end

  def self.project_id
    @configuration.project_id
  end

  def self.locales
    @configuration.locales
  end

  def self.processor
    @processor ||= SmartlingRails::SmartlingProcessor.new
  end

end
