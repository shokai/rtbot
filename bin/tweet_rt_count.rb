#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init [:db, :twitter]

parser = ArgsParser.parse ARGV do
  arg :help, 'show help', :alias => :h
  arg :tweet, 'tweet', :default => false
end

if parser.has_option? :help
  puts parser.help
  puts "e.g.  ruby -Ku #{$0}"
  puts "  => dry run, not tweet."
  puts "e.g.  ruby -Ku #{$0} --tweet"
  puts "  => tweet."
  exit 1
end

puts "notify plugin [#{Plugins.notify.keys.join(', ')}] loaded"

Plugins.notify.keys.sort{|a,b|
  b.to_i <=> a.to_i
}.each do |name|
  if name !~ /^\d+$/
    puts "plugin \"#{name}\" skipped.."
    next
  end

  stats = Status.find_by_retweet_count_not_tweeted(name.to_i, 100)
  
  if stats.count < 1
    puts "#{name}RT plugin : no tweets"
    next
  end

  stats.each_with_index do |s,i|
    i += 1
    puts "#{name}RT plugin (#{i}/#{stats.size})"
    res = Plugins::Notify.new(name.to_i, s).instance_eval Plugins.notify[name]
    puts "tweet \"#{res}\""
    unless parser[:tweet]
      puts " => not tweet (dry run) : please put --tweet switch   e.g. ruby #{$0} --tweet"
    else
      begin
        Twitter::update res
      rescue TimeoutError, StandardError => e
        STDERR.puts " => error : #{e}"
      else
        puts " => success"
        s.last_tweet_rtcount = name.to_i
        STDERR.puts "db save error.." unless s.save
      end
    end
    sleep 2
  end
  
end
