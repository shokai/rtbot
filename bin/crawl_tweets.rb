#!/usr/bin/env ruby
require File.dirname(__FILE__)+'/../bootstrap'
Bootstrap.init [:db, :twitter]

parser = ArgsParser.parser
parser.bind(:help, :h, 'show help')
parser.comment(:limit, 'number of crawling user', 10)
parser.comment(:paeg, 'page per one user (each page has 20 tweets)', 1)
first, params = parser.parse ARGV

if parser.has_option(:help)
  puts parser.help
  puts "e.g.  ruby -Ku #{$0} --limit 10 --page 2"
  exit 1
end

begin
  users = User.list_to_check params[:limit].to_i
rescue => e
  STDERR.puts e
  exit 1
end

users.each_with_index do |u, i|
  i += 1
  1.upto(params[:page].to_i) do |page|
    begin
      puts "(#{i}/#{users.size}) user : @#{u.screen_name} - (#{page}/#{params[:page].to_i}) page"
      tl = Twitter::user_timeline(u.user_id.to_i, {:include_rts => false, :page => page})
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
end
