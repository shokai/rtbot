
before Regexp.new "^/((timeline|hot|invisible)$|user/[a-zA-Z0-9_]+)" do
  @page = [(params['page'] || 1).to_i, 1].max
  @per_page = [(params['per_page'] || 40).to_i, 1].max
  @next_page = "#{request_url}?page=#{@page+1}&per_page=#{@per_page}"
  @prev_page = "#{request_url}?page=#{@page-1}&per_page=#{@per_page}" if @page > 1
end

get '/timeline' do
  @timeline = Status.timeline(:page => @page, :per_page => @per_page)
  @title = "#{@title} timeline"
  haml :timeline
end


get '/hot' do
  range = [Time.now-60*60*24, Time.now]
  @timeline = Status.find_by_tweeted_at(range).
    timeline(:type => :hot, :page => @page, :per_page => @per_page)
  @title = "#{@title} hot"
  haml :timeline
end

get '/invisible' do
  @timeline = Status.all(:visible => false).timeline(:page => @page, :per_page => @per_page)
  @title = "#{@title} invisible"
  haml :timeline
end

get '/user/:screen_name' do
  screen_name = params[:screen_name]
  @user = User.find_by_screen_name(screen_name)
  halt 404, 'user not found' unless @user
  @timeline = @user.timeline(:page => @page, :per_page => @per_page)
  @title = "#{@title} @#{@user.screen_name}"
  haml :timeline
end

get '/user/:screen_name/hot' do
  screen_name = params[:screen_name]
  @user = User.find_by_screen_name(screen_name)
  halt 404, 'user not found' unless @user
  range = [Time.now-60*60*24, Time.now]
  @timeline = @user.timeline(
                             {:page => @page, :per_page => @per_page, :type => :hot},
                             {:tweeted_at.gt => range.min-1, :tweeted_at.lt => range.max})
  @title = "#{@title} hot @#{@user.screen_name}"
  haml :timeline
end

get '/status/:status_id' do
  @status = Status.find_by_id params[:status_id]
  @user = @status.user
  halt 404, 'status not found' unless @status
  @title = "#{@title} @#{@user.screen_name}"
  haml :status
end
