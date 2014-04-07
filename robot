#!/usr/bin/env ruby

require './lib/robot'

robot = Robot.new
$stdin.each_line { |line|
  result = robot.execute_command line
  puts result if result
}
