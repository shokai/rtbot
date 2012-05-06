#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require
require 'yaml'

class Bootstrap
  def self.default
    [:plugin]
  end
  
  def self.init(inits=[])
    [default, inits].flatten.uniq.each do |i|
      path = "#{File.dirname(__FILE__)}/inits/#{i}"
      puts "loading #{path}"
      require path
    end

    Dir.glob(File.dirname(__FILE__)+'/helpers/*.rb').each do |rb|
      puts "loading #{rb}"
      require rb
    end
  end

  def self.conf_file
    File.dirname(__FILE__)+'/config.yml'
  end

  def self.conf
    begin
      @@conf ||= YAML::load self.open_conf_file.read
    rescue => e
      STDERR.puts e
      STDERR.puts "config.yml load error!!"
      exit 1
    end
  end
  
  def self.open_conf_file(opt=nil, &block)
    if block_given?
      yield open(self.conf_file, opt)
    else
      return open(self.conf_file, opt)
    end
  end
end
