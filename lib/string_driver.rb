class Robot
  # Accept string commands via #execute_command and pass to a robot instance.
  class StringDriver
    SUPPORTED_COMMANDS = %w(PLACE MOVE LEFT RIGHT REPORT)

    def initialize robot
      @robot = robot
    end

    def execute_command command
      command, arguments = parse_command command
      return unless supported_command? command, arguments

      result = @robot.send(command.downcase, *arguments)
      process_result command, result
    end

    private

    def parse_command command
      command.strip!
      command, arguments = command.split(/\s+/, 2)
      arguments = arguments ? arguments.split(/\s*,\s*/) : []
      [command, arguments]
    end

    def process_result command, result
      return unless command == 'REPORT'

      return if result.nil?
      result.to_s
    end

    def supported_command? command, arguments
      return unless SUPPORTED_COMMANDS.include? command
      return if command == 'PLACE' && arguments.size != 3
      true
    end
  end
end
