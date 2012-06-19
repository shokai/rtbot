#!/usr/bin/env ruby
require File.expand_path '../bootstrap', File.dirname(__FILE__)
Bootstrap.init [:db, :twitter]
require 'irb'

IRB.start
