require './direction'
require './table'

class Robot
  State = Struct.new(:x, :y, :direction) do
    def to_s
      [x, y, direction].join ','
    end
  end

  @@table = Table.new 5, 5

  def self.table
    @@table
  end

  def execute_command command
    command.strip!
    if command =~ /^PLACE\s+/
      return unless coords = parse_place_command(command)
      return unless @@table.inside?(coords.x, coords.y)

      @coords = coords
      return
    end
    return @coords ? @coords.to_s : nil if command == 'REPORT'

    move if command == 'MOVE'
    nil
  end

  private

  def move
    new_coords = @coords.clone
    case @coords.direction
    when Direction::NORTH then new_coords.y += 1
    when Direction::SOUTH then new_coords.y -= 1
    when Direction::EAST  then new_coords.x += 1
    when Direction::WEST  then new_coords.x -= 1
    end

    @coords = new_coords if @@table.inside?(new_coords.x, new_coords.y)
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
