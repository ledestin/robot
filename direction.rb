class Robot
  class Direction < String
    ALL = %w(NORTH EAST SOUTH WEST)

    def self.Direction direction
      raise ArgumentError, "#{direction}: unknown direction" \
	unless ALL.include? direction

      Direction.new direction
    end

    NORTH = Direction 'NORTH'
    EAST = Direction 'EAST'
    SOUTH = Direction 'SOUTH'
    WEST = Direction 'WEST'

    Kernel.class_eval <<-EOF
      def Direction direction
	Direction::Direction direction
      end
    EOF

    def next
      case self
      when NORTH then EAST
      when EAST then SOUTH
      when SOUTH then WEST
      when WEST then NORTH
      end
    end
  end
end
