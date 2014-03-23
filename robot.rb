class Robot
  def execute_command command
    command.strip!
    if command =~ /^PLACE ((?:(?:\d+)\s*,){2}NORTH)$/
      @coords = $1
      return
    end
    @coords if command == 'REPORT'
  end
end
