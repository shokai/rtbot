#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init [:db, :twitter]

parser = ArgsParser.parse ARGV do
  arg :help, 'show help', :alias => :h
  arg :user, 'number of user to check', :default => 10
  arg :page, 'page per one user (each page has 20 tweets)', :default => 1
end

if parser.has_option? :help
  puts parser.help
  puts "e.g.  ruby -Ku #{$0} --user 10 --page 2"
  exit 1
end

begin
  users = User.list_to_check parser[:user].to_i
rescue => e
  STDERR.puts e
  exit 1
end

users.each_with_index do |u, i|
  i += 1
  1.upto(parser[:page].to_i) do |page|
    begin
      puts "(#{i}/#{users.size}) user : @#{u.screen_name} - (#{page}/#{parser[:page].to_i}) page"
      tl = Twitter::user_timeline(u.user_id.to_i, {:include_rts => false, :page => page})
    rescue => e
      STDERR.puts "Error at user : @#{u.screen_name}"
      STDERR.puts e
      exit 1 if e.message =~ /rate limit/i
      sleep 2
      next
    end

    tl.each do |t|
      begin
        unless Status.exists? t.id
          stat = Status.new t
        else
          stat = Status.find_by_id t.id
          stat.retweet_count = t.retweet_count
        end
        puts stat
        stat.save
      rescue => e
        STDERR.puts "Error at user : @#{u.screen_name}"
        STDERR.puts e
        exit 1 if e.message =~ /rate limit/i
      end
    end
    u.last_checked_at = Time.now
    u.save
    sleep 2
  end
end
