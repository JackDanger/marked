module Marked
  def mark *objects

    Marked.log "\nMARKED #{caller.first.split(':in ').first}"

    returnable = block_given? ? yield : objects.last

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
end

class Object
  include Marked
end
