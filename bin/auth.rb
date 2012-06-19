#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init

consumer = OAuth::Consumer.new(
                               Bootstrap.conf['twitter']['consumer_key'],
                               Bootstrap.conf['twitter']['consumer_secret'],
                               :site => "http://twitter.com/"
                               )

request_token = consumer.get_request_token

puts 'please access following URL and approve'
puts request_token.authorize_url

print 'then, input OAuth Verifier: '
oauth_verifier = gets.chomp.strip

access_token = request_token.get_access_token(:oauth_verifier => oauth_verifier)

conf = Bootstrap.conf
conf['twitter']['access_token'] = access_token.token
conf['twitter']['access_secret'] = access_token.secret

begin
  Bootstrap.open_conf_file('w+'){|f|
    f.write conf.to_yaml
  }
rescue => e
  puts '-'*5
  puts '  access_token : ' + "'#{access_token.token}'"
  puts '  access_secret : ' + "'#{access_token.secret}'"
  puts '-'*5
end
