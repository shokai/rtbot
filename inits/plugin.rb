
class Plugins
  private
  def self.__cache
    @@cache ||= Hash.new
  end

  def self.method_missing(name, *args)
    __load_plugins(name)
  end

  private
  def self.__load_plugins(category)
    __cache[category] ||
      (
       hash = Hash.new
       Dir.glob(File.expand_path "../plugins/#{category}/*.rb", File.dirname(__FILE__)).each do |rb|
         name = rb.scan(/([^\/]+)\.rb$/i)[0][0]
         hash[name] = open(rb).read
       end
       __cache[category] = hash
       )
  end

  class Notify
    attr_reader :retweet_count, :status

    def initialize(retweet_count, status)
      unless status.kind_of? Status
        raise ArgumentError.new 'argument must be instance of Status'
      end
      @retweet_count = retweet_count
      @status = status
    end

    def method_missing(name, &args)
      instance_eval "status.#{name}(#{args})"
    end
  end
end


if __FILE__ == $0
  require 'pp'
  pp Plugins.notify
end
