
require 'rubygems'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require 'test/unit'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))


require 'active_support'
require 'active_support/test_case'
require 'flexmock'
require 'flexmock/test_unit'
