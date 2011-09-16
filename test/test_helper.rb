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

class Test::Unit::TestCase
  def setup
    Marked.stubs(:print_benchmark)
  end
end
