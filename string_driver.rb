class Robot
  class StringDriver
    SUPPORTED_COMMANDS = %w(PLACE MOVE LEFT RIGHT REPORT)

    def initialize robot
      @robot = robot
    end

    def execute_command command
      command.strip!
      command, arguments = command.split(/\s+/, 2)
      robot_args = [command.downcase]
      robot_args.concat arguments.split(/\s*,\s*/) if arguments
      return unless SUPPORTED_COMMANDS.include? command
      return if command == 'PLACE' && robot_args.size != 4

      ret = @robot.send *robot_args
      command == 'REPORT' ? ret : nil
    end
  end
end
