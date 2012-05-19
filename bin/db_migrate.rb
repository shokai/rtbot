#!/usr/bin/env ruby
require File.dirname(__FILE__)+'/../bootstrap'
Bootstrap.init :db

require 'dm-migrations'

puts 'migration will DELETE and RESET your DB.'
puts 'initialize DB?'
puts '[y/N]'
exit unless STDIN.gets =~ /y/i

DataMapper.auto_migrate!

puts 'DB migrate success!!'
