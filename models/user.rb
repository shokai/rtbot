require 'rubygems'
require 'data_mapper'

class User
  include DataMapper::Resource
  property :id, Serial
  property :user_id, String, :required => true, :unique => true, :length => 1..32
  property :screen_name, String, :required => true, :length => 1..256
  property :name, String, :required => true, :length => 0..256
  property :description, String, :default => '', :length => 0..1024
  property :last_checked_at, Time, :default => lambda{|r,p| Time.at 0 }

  def initialize(user)
    unless user.kind_of? Twitter::User
      raise ArgumentError.new 'Argument must be instance of Twitter:User'
    end
    self.user_id = user.id.to_s
    self.screen_name = user.screen_name.to_s
    self.name = user.name
    self.description = user.description
  end

  def to_s
    "id:#{user_id} @#{screen_name} (#{name}) - #{description}"
  end

  def self.exists?(user_id)
    user_id = user_id.to_s if user_id.kind_of? Integer
    raise ArgumentError 'Argument must be instance of String' unless user_id.kind_of? String
    self.count(:user_id => user_id) > 0
  end

  def self.find_by_id(user_id)
    self.all(:user_id => user_id, :limit => 1).first
  end

  def self.find_by_screen_name(screen_name)
    self.all(:screen_name => screen_name, :limit => 1).first
  end

  def self.list_to_check(limit = 20)
    self.all(:order => [:last_checked_at.asc], :limit => limit)
  end

  def self.last_checked_at
    self.all(:order => [:last_checked_at.desc], :limit => 1)[0].last_checked_at
  end

  def timeline(opts={}, opt_query={})
    opt_query[:user_id] = self.user_id
    Status.timeline(opts, opt_query)
  end

  def url
    "http://twitter.com/#{screen_name}"
  end
end


if __FILE__ == $0
  require File.expand_path '../bootstrap', File.dirname(__FILE__)
  Bootstrap.init [:db, :twitter]
  u = Twitter::user ARGV.empty? ? 'shokai' : ARGV.shift
  user = User.new u
  puts user
  puts user.save ? 'saved!' : 'save failed'
end
