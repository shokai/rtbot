
class User
  include DataMapper::Resource
  property :id, Serial
  property :user_id, Integer, :required => true
  property :screen_name, String, :required => true
end

