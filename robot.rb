class Robot
  DIRECTIONS = %w(NORTH EAST SOUTH WEST)

  def execute_command command
    command.strip!
    if command =~ /^PLACE ((?:(?:\d+)\s*,){2}(#{DIRECTIONS.join('|')}))$/o
      @coords = $1
      return
    end
    @coords if command == 'REPORT'
  end
end
