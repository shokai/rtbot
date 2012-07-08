
before Regexp.new "^/(timeline|hot)$" do
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
  range = Range.new Time.now-60*60*24, Time.now
  @timeline = Status.find_by_tweeted_at(range).
    timeline(:type => :hot, :page => @page, :per_page => @per_page)
  @title = "#{@title} hot"
  haml :timeline
end
