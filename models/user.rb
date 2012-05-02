require 'rubygems'
require 'data_mapper'

class User
  include DataMapper::Resource
  property :id, Serial
  property :user_id, Integer, :required => true, :unique => true
  property :screen_name, String, :required => true, :length => 0..256
  property :name, String, :required => true, :length => 0..256
  property :description, String, :required => true, :length => 0..1024
  property :last_checked_at, Time, :default => lambda{ Time.now }

  def initialize(user)
    unless user.kind_of? Twitter::User
      raise ArgumentError.new 'Argument must be instance of Twitter:User'
    end
    self.user_id = user.id
    self.screen_name = user.screen_name
    self.name = user.name
    self.description = user.description
  end

  def to_s
    "id:#{user_id} @#{screen_name} (#{name}) - #{description}"
  end

  def self.exists?(user_id)
    self.count(:user_id => user_id) > 0
  end

  def self.find_by_id(user_id)
    self.all(:user_id => user_id, :limit => 1).first
  end

  def self.find_by_screen_name(screen_name)
    self.all(:screen_name => screen_name, :limit => 1).first
  end

  def url
    "http://twitter.com/#{screen_name}"
  end
end


if __FILE__ == $0
  require File.dirname(__FILE__)+'/../bootstrap'
  Bootstrap.init [:db, :twitter]
  u = Twitter::user ARGV.empty? ? 'shokai' : ARGV.shift
  user = User.new u
  puts user
  puts user.save ? 'saved!' : 'save failed'
end
