module Marked
  def mark *objects

    returnable = block_given? ? yield : objects.last

    Marked.log "\nMARKED #{caller.first.split(':in ').first}"

    if block_given?
      Marked.log Marked.pad returnable
    end

    objects.each do |object|
      Marked.log Marked.pad object
    end

    returnable
  end

  def self.log object
    Rails.logger.debug object if defined?(Rails)
    print object
  end

  def self.print object
    STDOUT.puts object
  end

  def self.pad object
    "       " + (object.is_a?(String) ? object : object.inspect)
  end
end

class Object
  include Marked
end
