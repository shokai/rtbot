#!/usr/bin/env ruby
require File.dirname(__FILE__)+'/../bootstrap'
Bootstrap.init :db

require 'dm-migrations'
DataMapper.auto_upgrade!
