#!/usr/bin/env ruby
require File.dirname(__FILE__)+'/../bootstrap'
Bootstrap.init [:db, :twitter]

begin
  users = User.list_to_check 3
rescue => e
  STDERR.puts e
  exit 1
end

users.each_with_index do |u, i|
  i += 1
  begin
    puts "(#{i}/#{users.size}) user : @#{u.screen_name}"
    tl = Twitter::user_timeline u.user_id.to_i
    tl.each do |t|
      unless Status.exists? t.id
        stat = Status.new t
      else
        stat = Status.find_by_id t.id
        stat.retweet_count = t.retweet_count
      end
      p stat
      stat.save
    end
    u.last_checked_at = Time.now
    u.save
  rescue => e
    STDERR.puts "Error at user : @#{u.screen_name}"
    STDERR.puts e
    exit 1 if e.message =~ /rate limit/i
  end
  sleep 2
end
