require './string_driver'

describe Robot::StringDriver do
  before :each do
    @robot = double()
    @driver = Robot::StringDriver.new @robot
  end

  ['PLACE', 'MOVE', 'LEFT', 'RIGHT', 'REPORT'].each { |command|
    it "#{command} command calls corresponding robot method" do
      expect(@robot).to receive(command.downcase)
      @driver.execute_command command
    end
  }

  it 'not supported commands are not called on robot' do
    command = 'JUMP'
    expect(@robot).not_to receive(command)
    @driver.execute_command command
  end
end
