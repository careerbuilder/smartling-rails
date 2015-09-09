$:.push File.expand_path('../lib', __FILE__)

require 'smartling_rails/version'

Gem::Specification.new do |s|
  s.name        = 'smartling_rails'
  s.version     = SmartlingRails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = 'The CareerBuilder.com Consumer Development teams'
  s.email       = 'opensource@careerbuilder.com'
  s.homepage    = 'https://github.com/careerbuilder/smartling-rails'
  s.summary     = 'Smartling support library for automation of rails platforms using I18N'
  s.description = 'Smartling support library for automation of rails platforms using I18N'
  s.license     = 'Apache-2.0'

  s.files        = Dir['{lib}/**/*.rb', '*.md', '{lib}/tasks/*.rake']
  s.require_path = 'lib'

  s.add_dependency 'smartling', '~> 0.5'

  s.add_development_dependency 'rake', '~> 0.8'
  s.add_development_dependency 'simplecov', '~> 0.7', '>= 0.7.1'
  s.add_development_dependency 'rspec', '~> 2.11'
  s.add_development_dependency 'rspec-pride', '~> 2.2', '>= 2.2.0'
  s.add_development_dependency 'pry', '~> 0.9'
end
