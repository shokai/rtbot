
def stats
  {
    :tweet => {
      :count => Status.count,
      :last_checked_at => Status.last_checked_at
    },
    :user => {
      :count => User.count,
      :last_checked_at => User.last_checked_at
    }
  }
end

if __FILE__ == $0
  require File.expand_path '../bootstrap', File.dirname(__FILE__)
  Bootstrap.init :inits, :models

  p stats
end
