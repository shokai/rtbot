#!/usr/bin/env ruby
require File.dirname(__FILE__)+'/../bootstrap'
Bootstrap.init [:db, :twitter]

begin
  ids = Twitter.friend_ids.ids
rescue => e
  STDERR.puts e
  exit 1
end

ids.each do |id|
  unless User.exists? id
    u = User.new(:user_id => id)
    u.save
    puts "add #{u.user_id}"
  else
    puts "skip #{id}"
  end
end
