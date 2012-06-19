#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init :db

require 'dm-migrations'

puts 'migration will DELETE and RESET your DB.'
puts 'initialize DB?'
puts '[y/N]'
exit unless STDIN.gets =~ /y/i

DataMapper.auto_migrate!

puts 'DB migrate success!!'
