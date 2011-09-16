module Marked
  def mark *objects

    Marked.indent_out
    Marked.log "\nMARKED #{caller.first.split(':in ').first}"

    returnable = if block_given?
      require 'benchmark'
      result = nil
      bench = Benchmark.measure { result = yield }
      result
    else
      objects.last
    end

    objects.each do |object|
      Marked.log Marked.pad object
    end

    Marked.log Marked.pad returnable if block_given?

    Marked.print_benchmark bench if result

    Marked.rails_log " / FINISHED MARKING"

    Marked.indent_in
    returnable
  end

  class << self
    def log object
      rails_log object
      print object
    end

    def rails_log object
      Rails.logger.debug object if defined?(Rails)
    end

    def print object
      STDOUT.puts object
    end

    def pad object
      "       " + (" " * indent) + (object.is_a?(String) ? object : object.inspect)
    end

    def print_benchmark measurement
      log pad "* Executed in #{'%0.3f' % measurement.total} seconds (#{'%0.3f' % measurement.utime} cpu)\n"
    end

    def indent
      @indent ||= 0
    end

    def indent= integer
      @indent = integer
    end

    def indent_out
      @indent = indent + 1
    end

    def indent_in
      @indent = indent - 1
    end
  end
end

class Object
  include Marked
end
