require 'net/http'
require 'uri'

def exists_on_twitter?(screen_name)
  raise ArgumentError 'Argument must be Screen Name on Twitter' unless screen_name.kind_of? String
  uri = URI.parse "http://twitter.com/#{screen_name}"
  res = Net::HTTP.start(uri.host, uri.port).
    request(Net::HTTP::Head.new uri.request_uri)
  case res.code.to_i
  when 200
    true
  when 404
    false
  else
    raise StandardError, 'Twitter API not working'
  end
end
