
class Status
  include DataMapper::Resource
  property :id, Serial
  property :checked_at, Time, :default => lambda{ Time.now }
  property :stored_at, Time, :default => lambda{ Time.now }
  property :user_id, Integer, :required => true
  property :status_id, Integer, :required => true
  property :retweet_count, Integer, :required => true
  property :retweeters, String, :default => ''
  property :text, String, :default => ''

  def initialize(stat)
    unless stat.class == Twitter::Status
      raise ArgumentError.new('argument must be instance of Twitter::Status')
    end
    self.text = stat.text
    self.retweet_count
  end

  def user
  end

  def url
  end

end
