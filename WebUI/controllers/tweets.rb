
get '/timeline' do
  @page = (params['page'] || 1).to_i
  @per_page = (params['per_page'] || 40).to_i
  @timeline = Status.timeline :page => [@page,1].max, :per_page => [@per_page,1].max
  @next_page = "#{request_url}?page=#{@page+1}&per_page=#{@per_page}"
  @prev_page = "#{request_url}?page=#{@page-1}&per_page=#{@per_page}" if @page > 1
  @title = "#{@title} timeline"
  haml :timeline
end
