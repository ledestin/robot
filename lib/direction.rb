require 'forwardable'

class Robot
  class Direction
    Data = Struct.new(:delta_x, :delta_y)

    extend Forwardable

    DATA = {
      'NORTH' => Data.new(0, 1),
      'EAST' => Data.new(1, 0),
      'SOUTH' => Data.new(0, -1),
      'WEST' => Data.new(-1, 0)
    }.freeze

    def self.Direction direction
      return direction if direction.is_a? Direction

      Direction.new direction
    end

    attr_reader :name
    def_delegators :@data, :delta_x, :delta_y

    def initialize name
      replace name
    end

    def == other
      @name == other.name
    end

    def next
      case self
      when NORTH then EAST
      when EAST then SOUTH
      when SOUTH then WEST
      when WEST then NORTH
      end
    end

    def next!
      replace self.next
    end

    def prev
      case self
      when NORTH then WEST
      when WEST then SOUTH
      when SOUTH then EAST
      when EAST then NORTH
      end
    end

    def prev!
      replace prev
    end

    def to_s
      @name
    end

    private

    def replace other
      name = other.is_a?(String) ? other : other.name
      raise ArgumentError, "#{name}: unknown direction" \
	unless DATA.has_key? name

      @name, @data = name, DATA[name]
      self
    end

    public

    NORTH = Direction 'NORTH'
    EAST = Direction 'EAST'
    SOUTH = Direction 'SOUTH'
    WEST = Direction 'WEST'
    ALL = [NORTH, EAST, SOUTH, WEST].map! { |d| d.freeze }
  end
end

module Kernel
  def Direction direction
    Robot::Direction::Direction direction
  end
end
