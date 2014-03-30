require './direction'
require './string_driver'
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

  def initialize
    @driver = StringDriver.new self
  end

  def execute_command command
    @driver.execute_command command
  end

  def left
    @coords.direction.prev!
  end

  def move
    new_coords = @coords.clone
    case @coords.direction
    when Direction::NORTH then new_coords.y += 1
    when Direction::SOUTH then new_coords.y -= 1
    when Direction::EAST  then new_coords.x += 1
    when Direction::WEST  then new_coords.x -= 1
    end

    @coords = new_coords if @@table.contains?(new_coords.x, new_coords.y)
  end

  def place x, y, direction
    x, y, direction = Integer(x), Integer(y), Direction(direction)
    return unless @@table.contains? x, y

    @coords = State.new(x, y, direction)
  rescue ArgumentError
    return
  end

  def report
    @coords
  end
end
