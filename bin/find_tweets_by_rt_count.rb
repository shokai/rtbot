#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init [:db, :twitter]

parser = ArgsParser.parse ARGV do
  arg :help, 'show help', :alias => :h
  arg :rt_count, 'retweet count threshold', :alias => :rt
end


if parser.has_option? :help or !parser.has_param? :rt_count
  puts parser.help
  puts "e.g.  ruby -Ku #{$0} -rt 3"
  exit 1
end

stats = Status.find_by_retweet_count(parser[:rt_count].to_i, 100)

stats.each_with_index do |s,i|
  i += 1
  puts "(#{i}/#{stats.size}) [#{s.retweet_count}RT] #{s} - #{s.url}"
end
