class Robot
  State = Struct.new(:x, :y, :direction) do
    def to_s
      [x, y, direction].join ','
    end
  end
end
