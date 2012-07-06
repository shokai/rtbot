#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init [:db, :twitter]

parser = ArgsParser.parse ARGV do
  arg :help, 'show help', :alias => :h
  arg :name, 'twitter screen name'
end

if parser.has_option? :help or !parser.has_param? :name or !parser.first
  puts parser.help
  puts "e.g.  ruby #{$0} add -name USER_NAME"
  puts "e.g.  ruby #{$0} remove -name USER_NAME"
end

case parser.first
when 'add'
  u = Twitter::user parser[:name]
  if User.exists? u.id
    puts 'user already exists.'
    exit
  end
  user = User.new u
  puts user
  puts user.save ? 'saved!' : 'save failed'
when 'remove'
  user = User.find_by_screen_name parser[:name]
  unless user
    puts "user @#{parser[:name]} not exists."
    exit
  end
  puts user
  puts user.destroy ? 'removed!' : 'remove failed'
end
