class Robot
  State = Struct.new(:x, :y, :direction) do
    def initialize x, y, direction
      self.x, self.y, self.direction =
	Integer(x), Integer(y), Direction(direction)
    end

    def to_s
      [x, y, direction].join ','
    end
  end
end
