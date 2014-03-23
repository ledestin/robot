class Robot
  DIRECTIONS = %w(NORTH EAST SOUTH WEST)
  TABLE_WIDTH = 5
  INTEGER_REGEX = /^\d+$/

  PlaceCoords = Struct.new(:x, :y, :direction) do
    def to_s
      [x, y, direction].join ','
    end
  end

  def execute_command command
    command.strip!
    if command =~ /^PLACE\s+/
      return unless coords = parse_place_command(command)
      return if coords.x > TABLE_WIDTH

      @coords = coords.to_s
      return
    end
    @coords if command == 'REPORT'
  end

  private

  def parse_place_command str
    x, y, direction = str.split(/\s+/, 2).last.split(/\s*,\s*/)
    begin
      x, y = Integer(x), Integer(y)
    rescue ArgumentError
      return
    end
    return unless direction =~ /^(#{DIRECTIONS.join('|')})$/

    PlaceCoords.new x, y, direction
  end
end
