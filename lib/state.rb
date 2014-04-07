require './lib/direction'

class Robot
  class StateArgumentError < ArgumentError; end

  State = Struct.new(:x, :y, :direction) do
    def initialize x, y, direction
      self.x, self.y, self.direction =
	Integer(x), Integer(y), Direction(direction)
    rescue ArgumentError
      raise StateArgumentError, $!.message
    end

    def to_s
      [x, y, direction].join ','
    end
  end
end
