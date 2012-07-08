before '/*.json' do
  content_type 'application/json'
end

before '/*' do
  @title = Conf['db']['database']
end

get '/' do
  haml :index
end

get '/stats' do
  @title = "#{@title} status"
  @stats = stats
  haml :stats
end

get '/stats.json' do
  stats.to_json
end
