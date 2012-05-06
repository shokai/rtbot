
class Bootstrap
  def self.plugins(category)
    hash = Hash.new
    Dir.glob(File.dirname(__FILE__)+"/../plugins/#{category}/*.rb").each do |rb|
      name = rb.scan(/([^\/]+)\.rb$/i)[0][0]
      hash[name] = open(rb).read
    end
    hash
  end
end


if __FILE__ == $0
  require 'pp'
  pp Bootstrap.plugins :notify
end
