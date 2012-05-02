#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require
require 'yaml'

class Bootstrap
  def self.default
    []
  end
  
  def self.init(inits=[])
    [default, inits].flatten.uniq.each do |i|
      path = "#{File.dirname(__FILE__)}/inits/#{i}"
      puts "loading #{path}"
      require path
    end
  end

  def self.conf
    begin
      @@conf ||= YAML::load open(File.dirname(__FILE__)+'/config.yml').read
    rescue => e
      STDERR.puts e
      STDERR.puts "config.yml load error!!"
      exit 1
    end
  end
end
