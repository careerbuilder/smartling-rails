require 'simplecov'
require 'pry'
require 'ostruct'

SimpleCov.start do
  add_filter '/spec/'
  add_group 'models', 'lib/smarlting_rails/models'
end

require 'smartling_rails'

#Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
