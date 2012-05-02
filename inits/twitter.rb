Twitter.configure do |config|
  config.consumer_key = Bootstrap.conf['twitter']['consumer_key']
  config.consumer_secret = Bootstrap.conf['twitter']['consumer_secret']
  config.oauth_token = Bootstrap.conf['twitter']['access_token']
  config.oauth_token_secret = Bootstrap.conf['twitter']['access_secret']
end
