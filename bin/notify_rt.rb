#!/usr/bin/env ruby
require File.dirname(__FILE__)+'/../bootstrap'
Bootstrap.init [:db, :twitter]

parser = ArgsParser.parser
parser.bind(:help, :h, 'show help')
parser.bind(:rt_count, :rt, 'retweet count threshold', 1)
first, params = parser.parse ARGV

if parser.has_option(:help)
  puts parser.help
  puts "e.g.  ruby -Ku #{$0} -rt 3"
  exit 1
end

stats = Status.find_by_retweet_count(params[:rt_count], 100)

stats.each_with_index do |s,i|
  i += 1
  puts "(#{i}/#{stats.size}) [#{s.retweet_count}RT] #{s} - #{s.url}"
end
