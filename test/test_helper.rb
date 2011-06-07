require 'test/unit'
require File.expand_path File.join(File.dirname(__FILE__), '..', 'lib', 'marked')
require 'shoulda'
require 'mocha'


module Rails
  Logger = {}
  def self.logger
    Logger
  end
end