class Robot
  class Direction < String
    ALL_STR = %w(NORTH EAST SOUTH WEST)

    def self.Direction direction
      raise ArgumentError, "#{direction}: unknown direction" \
	unless ALL_STR.include? direction

      Direction.new direction
    end

    NORTH = Direction 'NORTH'
    EAST = Direction 'EAST'
    SOUTH = Direction 'SOUTH'
    WEST = Direction 'WEST'
    ALL = [NORTH, EAST, SOUTH, WEST].map! { |d| d.freeze }

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
      replace self.prev
    end
  end
end
