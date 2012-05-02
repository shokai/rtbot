
class User
  include DataMapper::Resource
  property :user_id, Serial
  property :screen_name, String, :required => true
  property :name, String, :required => true
  property :description, String, :required => true

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
