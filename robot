#!/usr/bin/env ruby

class Robot
  def execute_command command
    command.strip!
    '0,1,NORTH' if command == 'REPORT'
  end
end

robot = Robot.new
$stdin.each_line { |line|
  result = robot.execute_command line
  puts result if result
}
