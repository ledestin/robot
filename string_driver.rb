class Robot
  class StringDriver
    SUPPORTED_COMMANDS = %w(PLACE MOVE LEFT RIGHT REPORT)

    def initialize robot
      @robot = robot
    end

    def execute_command command
      return unless SUPPORTED_COMMANDS.include? command

      @robot.send command.downcase
    end
  end
end
