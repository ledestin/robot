class Robot
  class StringDriver
    SUPPORTED_COMMANDS = %w(PLACE MOVE LEFT RIGHT REPORT)

    def initialize robot
      @robot = robot
    end

    def execute_command command
      command, arguments = parse_command command
      return unless supported_command? command, arguments

      ret = @robot.send(command.downcase, *arguments)
      return unless command == 'REPORT'

      ret = ret.to_s if ret
      ret
    end

    private

    def parse_command command
      command.strip!
      command, arguments = command.split(/\s+/, 2)
      arguments = arguments ? arguments.split(/\s*,\s*/) : []
      [command, arguments]
    end

    def supported_command? command, arguments
      return unless SUPPORTED_COMMANDS.include? command
      return if command == 'PLACE' && arguments.size != 3
      true
    end
  end
end
