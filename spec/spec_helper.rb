require 'simplecov'
SimpleCov.start

require 'dotenv'
Dotenv.load

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
