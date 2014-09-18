require './lib/direction'

class Robot
  class State < Struct.new(:x, :y, :direction)
    class ArgumentError < ::ArgumentError; end

    def initialize x, y, direction
      self.x, self.y, self.direction =
	Integer(x), Integer(y), Direction(direction)
    rescue ::ArgumentError
      raise ArgumentError, $!.message
    end

    def step!
      self.x += direction.delta_x
      self.y += direction.delta_y
    end

    def to_s
      [x, y, direction].join ','
    end
  end
end
