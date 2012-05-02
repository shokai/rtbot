
class User
  include DataMapper::Resource
  property :user_id, Serial
  property :screen_name, String, :default => ''


  def self.exists?(user_id)
    self.count(:user_id => user_id) > 0
  end

  def self.find_by_id(user_id)
    self.all(:user_id => user_id, :limit => 1).first
  end
end
