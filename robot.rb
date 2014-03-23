class Robot
  DIRECTIONS = %w(NORTH EAST SOUTH WEST)
  TABLE_WIDTH = 5
  INTEGER_REGEX = /^\d+$/

  def execute_command command
    command.strip!
    if command =~ /^PLACE\s+/
      x, y, direction = parse_place_command command
      return unless x
      return if x > TABLE_WIDTH

      @coords = [x, y, direction].join(',')
      return
    end
    @coords if command == 'REPORT'
  end

  private

  def parse_place_command str
    x, y, direction = str.split(/\s+/, 2).last.split /\s*,\s*/
    begin
      x, y = Integer(x), Integer(y)
    rescue ArgumentError
      return
    end
    return unless direction =~ /^(#{DIRECTIONS.join('|')})$/
    [x, y, direction]
  end
end
