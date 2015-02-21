=begin
require 'rubygems'
require 'smartling'
load 'localizer_files/cb_smartling.rb'
load 'localizer_files/localizer_helpers.rb'

ARGV << "--help" if ARGV.empty?

@command = ARGV.shift
@command = @command_aliases[@command] || @command
@my_smartling = nil

def make_my_smartling
  @my_smartling ||= CBSmartling.new()
end

def print_help
  print_msg("Localizer Help:", true)
  @command_aliases.each do |command_alias, command|
    print_msg("    #{command} or #{command_alias} does.....")
  end
end

def execute_command
  if command_is('h')
    print_help()
  elsif command_is('s')
    @my_smartling.get_status()
  elsif command_is('g')
    @my_smartling.get_files()
  elsif command_is('p')
    @my_smartling.put_files()
  end
end

def startup()
  make_my_smartling()
  execute_command()
end

startup()
=end
