module Marker
  def mark *objects

    # send to Rails log, if available
    logger = proc do |object|
      if defined?(Rails)
        Rails.logger.info object.is_a?(String) ? object : object.inspect
      end
    end

    # send to standard out and logger
    printer = proc do |object|
      STDOUT.puts object.is_a?(String) ? object : object.inspect
      logger.call object
    end

    returnable = block_given? ? yield : objects.last

    logger.call "<MARK>"

    if block_given?
      printer.call returnable
    end

    objects.each do |object|
      printer.call
    end

    logger.call "</MARK>"

    returnable
  end
end

class Object
  include Marker
end