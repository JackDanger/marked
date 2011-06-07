module Marker
  def mark *objects

    returnable = block_given? ? yield : objects.last

    Marker.log "<MARK>"

    if block_given?
      Marker.print returnable
      Marker.log   returnable
    end

    objects.each do |object|
      Marker.print object
      Marker.log   object
    end

    Marker.log "</MARK>"

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
  include Marker
end