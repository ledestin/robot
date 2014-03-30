class Robot
  class StringDriver
    SUPPORTED_COMMANDS = %w(PLACE MOVE LEFT RIGHT REPORT)

    def initialize robot
      @robot = robot
    end

    def execute_command command
      return unless SUPPORTED_COMMANDS.include? command

      ret = @robot.send command.downcase
      command == 'REPORT' ? ret : nil
    end
  end
end
