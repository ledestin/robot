require './direction'

class Robot
  TABLE_HEIGHT = 5
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
      return if coords.x > TABLE_WIDTH || coords.y > TABLE_HEIGHT

      @coords = coords
      return
    end
    return @coords ? @coords.to_s : nil if command == 'REPORT'

    if command == 'MOVE'
      case @coords.direction
      when 'NORTH'
	@coords.y += 1
      when 'SOUTH'
	@coords.y -= 1
      when 'EAST'
	@coords.x += 1
      when 'WEST'
	@coords.x -= 1
      end
    end
  end

  private

  def parse_place_command str
    x, y, direction = str.split(/\s+/, 2).last.split(/\s*,\s*/)
    begin
      x, y, direction = Integer(x), Integer(y), Direction(direction)
    rescue ArgumentError
      return
    end

    PlaceCoords.new x, y, direction
  end
end
