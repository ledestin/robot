class Robot
  class Direction
    ALL_STR = %w(NORTH EAST SOUTH WEST)

    def self.Direction direction
      return direction if direction.is_a? Direction

      raise ArgumentError, "#{direction}: unknown direction" \
	unless ALL_STR.include? direction

      Direction.new direction
    end

    attr_reader :name

    def initialize name
      @name = name
    end

    NORTH = Direction 'NORTH'
    EAST = Direction 'EAST'
    SOUTH = Direction 'SOUTH'
    WEST = Direction 'WEST'
    ALL = [NORTH, EAST, SOUTH, WEST].map! { |d| d.freeze }

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
      @name = self.next.name
      self
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
      @name = prev.name
      self
    end

    def to_s
      @name
    end
  end
end

module Kernel
  def Direction direction
    Robot::Direction::Direction direction
  end
end
