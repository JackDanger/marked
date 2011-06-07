module Marked
  def mark *objects

    returnable = block_given? ? yield : objects.last

    Marked.log "<MARK>"

    if block_given?
      Marked.print returnable
      Marked.log   returnable
    end

    objects.each do |object|
      Marked.print object
      Marked.log   object
    end

    Marked.log "</MARK>"

    returnable
  end

  def self.log object
    if defined?(Rails)
      Rails.logger.debug object.is_a?(String) ? object : object.inspect
    end
  end

  def self.print object
    STDOUT.puts object.is_a?(String) ? object : object.inspect
  end
end

class Object
  include Marked
end