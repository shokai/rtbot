
post '/api/status/:status_id/visible.json' do
  visible = params['visible']
  visible = 
    case visible
    when 'true'
      true
    when 'false'
      false
    else
      halt 400, 'bad request'
    end
  status_id = params[:status_id]
  @status = Status.find_by_id status_id
  halt 404, 'status not found' unless @status
  @status.visible = visible
  halt 500, 'save error' unless @status.save
  @status.to_json
end
