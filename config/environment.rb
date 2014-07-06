require 'bundler/setup'
Bundler.require

Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].each {|f| require f}