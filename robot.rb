require './direction'

class Robot
  State = Struct.new(:x, :y, :direction) do
    def to_s
      [x, y, direction].join ','
    end
  end

  TABLE_HEIGHT = 5
  TABLE_WIDTH = 5

  def execute_command command
    command.strip!
    if command =~ /^PLACE\s+/
      return unless coords = parse_place_command(command)
      return if coords.x > TABLE_WIDTH || coords.y > TABLE_HEIGHT

      @coords = coords
      return
    end
    return @coords ? @coords.to_s : nil if command == 'REPORT'

    move if command == 'MOVE'
    nil
  end

  private

  def can_move?
    case @coords.direction
    when Direction::NORTH
      @coords.y + 1 <= TABLE_HEIGHT
    when Direction::SOUTH
      @coords.y - 1 >= 0
    when Direction::EAST
      @coords.x + 1 <= TABLE_WIDTH
    when Direction::WEST
      @coords.x - 1 >= 0
    end
  end

  def move
    return unless can_move?

    case @coords.direction
    when Direction::NORTH
      @coords.y += 1
    when Direction::SOUTH
      @coords.y -= 1
    when Direction::EAST
      @coords.x += 1
    when Direction::WEST
      @coords.x -= 1
    end
  end

  def parse_place_command str
    x, y, direction = str.split(/\s+/, 2).last.split(/\s*,\s*/)
    begin
      x, y, direction = Integer(x), Integer(y), Direction(direction)
    rescue ArgumentError
      return
    end

    State.new x, y, direction
  end
end
