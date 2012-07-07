#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init :db

parser = ArgsParser.parse ARGV do
  arg :help, 'show help', :alias => :h
  arg :limit, 'number of tweets', :default => 20
  arg :start, 'Start of Tweet Timestamp', :default => Time.now.to_i-60*60*24
  arg :end, 'End of Tweet Timestamp', :default => Time.now.to_i
  arg :output, 'output file', :alias => :o
  arg :format, 'output file format'
  arg :template, 'template file', :alias => :t
  arg :min_rt_count, 'Min ReTweet count', :default => 1
end

if parser.has_option? :help or !parser.has_param? :format or (parser[:format] =~ /html/ and !parser.has_param? :template)
  puts parser.help
  puts "ruby #{$0} -output out.json -format json"
  puts "ruby #{$0} -output out.json -format html -template template.haml"
  exit 1
end

range = Range.new Time.at(parser[:start].to_i), Time.at(parser[:end].to_i)
stats = Status.find_by_tweeted_at(range).
  all(:retweet_count.gt => (parser[:min_rt_count].to_i-1),
      :order => [:retweet_count.desc],
      :limit => parser[:limit].to_i)

out =
  case parser[:format]
  when /json/
    stats.to_json
  when /html/
    Haml::Engine.new(File.open(parser[:template]).read).render(Object.new, :stats => stats)
  end

unless parser[:output]
  puts out
else
  File.open(parser[:output], 'w+') do |f|
    f.write out
  end
  puts "output => #{parser[:output]}"
end
