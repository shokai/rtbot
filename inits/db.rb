DataMapper.setup(:default, Bootstrap.conf['db'])

Dir.glob(File.dirname(__FILE__)+'/../models/*.rb').each do |rb|
  puts "loading #{rb}"
  require rb
end

DataMapper::Logger.new($stdout, :debug)
DataMapper.finalize
