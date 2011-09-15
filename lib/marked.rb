module Marked
  def mark *objects

    Marked.log "\nMARKED #{caller.first.split(':in ').first}"

    returnable = if block_given?
      require 'benchmark'
      result = nil
      bench = Benchmark.measure { result = yield }
      Marked.print_benchmark bench
      result
    else
      objects.last
    end

    if block_given?
      Marked.log Marked.pad returnable
    end

    objects.each do |object|
      Marked.log Marked.pad object
    end

    Marked.rails_log " / FINISHED MARKING"

    returnable
  end

  def self.log object
    rails_log object
    print object
  end

  def self.rails_log object
    Rails.logger.debug object if defined?(Rails)
  end

  def self.print object
    STDOUT.puts object
  end

  def self.pad object
    "       " + (object.is_a?(String) ? object : object.inspect)
  end

  def self.print_benchmark measurement
    log "       * Executed in #{'%0.3f' % measurement.total} seconds (#{'%0.3f' % measurement.utime} cpu)\n"
  end
end

class Object
  include Marked
end
