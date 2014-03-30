require './string_driver'

describe Robot::StringDriver do
  before :each do
    @robot = double()
    @driver = Robot::StringDriver.new @robot
  end

  Robot::StringDriver::SUPPORTED_COMMANDS.each { |command|
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

  context 'value returned by robot method is ignored for' do
    (Robot::StringDriver::SUPPORTED_COMMANDS - ['REPORT']).each { |command|
      it command do
	allow(@robot).to receive(command.downcase) { 'result' }
	expect(@driver.execute_command command).to eq nil
      end
    }
  end

  it "#execute_command 'REPORT' returns value returned by robot" do
    allow(@robot).to receive(:report) { 'result' }
    expect(@driver.execute_command 'REPORT').not_to eq nil
  end
end
