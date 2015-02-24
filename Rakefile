
require 'bundler'
import "./lib/tasks/smartling_rails.rake"
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color -fd'
  t.pattern = 'spec/**/*_spec.rb'
end

desc 'Run all specs then immediately open the coverage report'
task :coverage do
  begin
    Rake::Task[:spec].execute
  rescue Exception
    # eat the 'exception' that is the non-zero exit code caused by failing tests
  end
  `open coverage/index.html` if RUBY_PLATFORM.downcase.include?('darwin')
  `start coverage/index.html` if RUBY_PLATFORM.downcase.include?('mswin')
end

desc 'Run Tests'
task :default => :spec
