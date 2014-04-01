require 'naught'
require './direction'
require './string_driver'
require './state'
require './table'

class Robot
  @@table = Table.new 5, 5

  def self.table
    @@table
  end

  # Null object, to be used as robot state.
  BlackHole = Naught.build do |config|
    config.black_hole
    config.singleton
    config.define_implicit_conversions
  end

  def initialize
    # Parsing of string commands is handled by StringDriver.
    @driver = StringDriver.new self
    @coords = BlackHole.instance
  end

  # Execute command and return any output as a String.
  # @command is a string command, e.g. 'REPORT'.
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

    @coords = new_coords if @@table.contain?(new_coords.x, new_coords.y)
  end

  def right
    @coords.direction.next!
  end

  def place x, y, direction
    x, y, direction = Integer(x), Integer(y), Direction(direction)
    return unless @@table.contain? x, y

    @coords = State.new(x, y, direction)
  rescue ArgumentError
  end

  def report
    @coords
  end
end
