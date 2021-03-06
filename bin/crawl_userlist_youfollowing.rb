#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init [:db, :twitter]

begin
  ids = Twitter.friend_ids.ids
rescue => e
  STDERR.puts e
  exit 1
end

ids.each_with_index do |id, i|
  i += 1
  begin
    unless User.exists? id
      u = User.new Twitter::user(id)
      puts u
      raise StandardError.new "save error user_id:#{id}" unless u.save
      puts "(#{i}/#{ids.size}) add #{u}"
    else
      puts "(#{i}/#{ids.size}) skip #{id}"
      next
    end
  rescue => e
    STDERR.puts "(#{i}/#{ids.size}) Error at user_id : #{id}"
    STDERR.puts e
    exit 1 if e.message =~ /rate limit/i
  end
  sleep 2
end
