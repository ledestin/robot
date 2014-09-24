require 'forwardable'

class Robot
  class Direction
    Definition = Struct.new(:prev_name, :next_name, :delta_x, :delta_y)

    extend Forwardable

    DEFINITIONS = {
      'NORTH' => Definition.new('WEST', 'EAST', 0, 1),
      'EAST' => Definition.new('NORTH', 'SOUTH', 1, 0),
      'SOUTH' => Definition.new('EAST', 'WEST', 0, -1),
      'WEST' => Definition.new('SOUTH', 'NORTH', -1, 0)
    }.freeze

    def self.Direction direction
      return direction if direction.is_a? Direction

      Direction.new direction
    end

    attr_reader :name
    def_delegators :@data, :prev_name, :next_name, :delta_x, :delta_y

    def initialize name
      replace name
    end

    def == other
      @name == other.name
    end

    def next
      self.class.const_get next_name
    end

    def next!
      replace self.next
    end

    def prev
      self.class.const_get prev_name
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
	unless DEFINITIONS.has_key? name

      @name, @data = name, DEFINITIONS[name]
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
