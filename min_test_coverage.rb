#!/usr/bin/env ruby
require 'json'
puts 'I was passed: '
last_run_file = ARGV[0]
min_test_percent = ARGV[1].to_f

file = File.read(last_run_file)
file_contents = JSON.parse(file)
test_percent = file_contents['result']['covered_percent'].to_f

puts "We had #{test_percent} and needed #{min_test_percent}"
exit test_percent >= min_test_percent 