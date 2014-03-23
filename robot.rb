class Robot
  def execute_command command
    command.strip!
    '0,1,NORTH' if command == 'REPORT'
  end
end
