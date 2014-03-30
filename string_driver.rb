class Robot
  class StringDriver
    SUPPORTED_COMMANDS = %w(PLACE MOVE LEFT RIGHT REPORT)

    def initialize robot
      @robot = robot
    end

    def execute_command command
      command.strip!
      command, arguments = command.split(/\s+/, 2)
      arguments = arguments ? arguments.split(/\s*,\s*/) : []
      return unless SUPPORTED_COMMANDS.include? command
      return if command == 'PLACE' && arguments.size != 3

      ret = @robot.send(command.downcase, *arguments)
      command == 'REPORT' ? ret : nil
    end
  end
end
