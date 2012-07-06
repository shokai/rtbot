#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init :db

require 'dm-migrations'
DataMapper.auto_upgrade!
