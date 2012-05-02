#!/usr/bin/env ruby
require File.dirname(__FILE__)+'/../bootstrap'
Bootstrap.init [:db, :twitter]

begin
  ids = Twitter.friend_ids.ids
rescue => e
  STDERR.puts e
  exit 1
end

ids.each_with_index do |id, i|
  begin
    unless User.exists? id
      _u = Twitter::user(id)
      u = User.new(
                   :user_id => id,
                   :screen_name => _u.screen_name,
                   :name => _u.name,
                   :description => _u.description
                   )
      u.save
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
