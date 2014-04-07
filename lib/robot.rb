require 'naught'
require './lib/direction'
require './lib/string_driver'
require './lib/state'
require './lib/table'

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

  def initialize driver_klass=StringDriver
    @driver = driver_klass.new self
    @coords = BlackHole.instance
  end

  # Execute command and return any output as a String.
  # @command is a string command, e.g. 'REPORT'.
  def execute_command command
    @driver.execute_command command
  end

  def left
    direction.prev!
  end

  def move
    new_coords = @coords.clone
    case direction
    when Direction::NORTH then new_coords.y += 1
    when Direction::SOUTH then new_coords.y -= 1
    when Direction::EAST  then new_coords.x += 1
    when Direction::WEST  then new_coords.x -= 1
    end

    @coords = new_coords if @@table.contain?(new_coords.x, new_coords.y)
  end

  def right
    direction.next!
  end

  def place x, y, direction
    new_coords = State.new(x, y, direction)
    return unless @@table.contain? new_coords.x, new_coords.y

    @coords = new_coords
  rescue StateArgumentError
  end

  def report
    @coords
  end

  private

  def direction
    @coords.direction
  end
end
