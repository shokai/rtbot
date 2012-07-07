#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init

user = ARGV.empty? ? 'shokai' : ARGV.shift
puts "check @#{user}"
puts exists_on_twitter? user
