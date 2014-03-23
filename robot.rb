class Robot
  DIRECTIONS = %w(NORTH EAST SOUTH WEST)
  MAX_WIDTH = 5
  INTEGER_REGEX = /^\d+$/

  def execute_command command
    command.strip!
    if command =~ /^PLACE\s+(.+)$/
      x, y, direction = $1.split /\s*,\s*/
      return unless x =~ INTEGER_REGEX && y =~ INTEGER_REGEX &&
	direction =~ /^(#{DIRECTIONS.join('|')})$/
      return if x.to_i > MAX_WIDTH

      @coords = [x, y, direction].join(',')
      return
    end
    @coords if command == 'REPORT'
  end
end
