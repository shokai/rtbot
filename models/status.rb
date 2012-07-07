require 'rubygems'
require 'data_mapper'

class Status
  include DataMapper::Resource
  property :id, Serial
  property :status_id, String, :required => true, :unique => true, :length => 1..32
  property :text, String, :default => '', :length => 1..512
  property :tweeted_at, Time, :required => true
  property :stored_at, Time, :default => lambda{|r,p| Time.now }
  property :last_checked_at, Time, :default => lambda{|r,p| Time.now }
  property :user_id, String, :required => true, :length => 1..32
  property :retweet_count, Integer, :required => true
  property :retweeters, String, :default => '', :length => 0..512
  property :last_tweet_rtcount, Integer, :default => 0

  def initialize(stat)
    unless stat.kind_of? Twitter::Status
      raise ArgumentError.new 'Argument must be instance of Twitter::Status'
    end
    self.status_id = stat.id.to_s
    self.text = stat.text
    self.tweeted_at = stat.created_at
    self.user_id = stat.user.id.to_s
    self.retweet_count = stat.retweet_count
  end

  def self.exists?(status_id)
    status_id = status_id.to_s if status_id.kind_of? Integer
    raise ArgumentError 'Argument must be instance of String' unless status_id.kind_of? String
    self.count(:status_id => status_id) > 0
  end

  def self.find_by_id(status_id)
    self.all(:status_id => status_id).first
  end

  def self.find_by_retweet_count(rt_count, limit=10)
    self.all(:retweet_count.gt => (rt_count-1), :limit => limit)
  end

  def self.find_by_retweet_count_not_tweeted(rt_count, limit=10)
    self.all(:retweet_count.gt => (rt_count-1),
             :last_tweet_rtcount.lt => rt_count,
             :limit => limit)
  end

  def self.find_by_tweeted_at(range)
    first = range.min
    first = Time.at first unless first.kind_of? Time
    end_ = range.max
    end_ = Time.at end_ unless end_.kind_of? Time
    self.all(:tweeted_at.gt => first-1,
             :tweeted_at.lt => end_)
  end

  def to_s
    "@#{user.screen_name} #{text} - #{tweeted_at}"
  end

  def user
    @user ||= User.find_by_id(self.user_id)
  end

  def url
    "http://twitter.com/#{self.user.screen_name}/status/#{status_id}"
  end

end


if __FILE__ == $0
  require File.expand_path '../bootstrap', File.dirname(__FILE__)
  Bootstrap.init [:db, :twitter]
  tl = Twitter::user_timeline Twitter::friend_ids.ids.sample
  tl.each do |t|
    stat = Status.new t
    p stat
    puts stat.save ? 'saved!' : 'save failed'
  end
end
