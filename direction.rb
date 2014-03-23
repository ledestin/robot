class Robot
  class Direction < String
    ALL = %w(NORTH EAST SOUTH WEST)

    def self.Direction direction
      raise ArgumentError, "#{direction}: unknown direction" \
	unless ALL.include? direction

      Direction.new direction
    end

    Robot.class_eval <<-EOF
      def Direction direction
	Direction::Direction direction
      end
    EOF
  end
end
