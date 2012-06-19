DataMapper.setup(:default, Bootstrap.conf['db'])

Dir.glob(File.expand_path '../models/*.rb', File.dirname(__FILE__)).each do |rb|
  puts "loading #{rb}"
  require rb
end

DataMapper::Logger.new($stdout, :debug)
DataMapper.finalize
