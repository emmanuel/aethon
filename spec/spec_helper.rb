require 'minitest/autorun'
require 'minitest/rspec'

lib_path = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_path unless $LOAD_PATH.include?(lib_path)

require 'aethon'
