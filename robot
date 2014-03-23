#!/usr/bin/env ruby

class Robot
  def execute_command command
  end
end

robot = Robot.new
$stdin.each_line { |line|
  robot.execute_command line
}
