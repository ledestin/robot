class Robot
  class Direction < String
    NORTH = 'NORTH'
    EAST = 'EAST'
    SOUTH = 'SOUTH'
    WEST = 'WEST'
    ALL = [NORTH, EAST, SOUTH, WEST]

    def self.Direction direction
      raise ArgumentError, "#{direction}: unknown direction" \
	unless ALL.include? direction

      Direction.new direction
    end

    Kernel.class_eval <<-EOF
      def Direction direction
	Direction::Direction direction
      end
    EOF
  end
end
