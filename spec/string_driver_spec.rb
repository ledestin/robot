require 'spec_helper'
require './string_driver'

describe Robot::StringDriver do
  before :each do
    @robot = double()
    @driver = Robot::StringDriver.new @robot
  end

  context '#execute_command(command) calls corresponding robot method' do
    (Robot::StringDriver::SUPPORTED_COMMANDS - ['PLACE']).each { |command|
      it "(#{command})" do
	expect(@robot).to receive(command.downcase)
	@driver.execute_command command
      end
    }
  end

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

  context 'PLACE command requires 3 arguments to be passed to robot,' do
    it 'is passed to robot when given 3 arguments' do
      allow(@robot).to receive(:place)
      @driver.execute_command 'PLACE 0,0,NORTH'
      expect(@robot).to have_received(:place).with('0', '0', 'NORTH')
    end

    context "isn't passed to robot when" do
      before :each do
	expect(@robot).not_to receive(:place)
      end

      it 'no arguments given' do
	@driver.execute_command 'PLACE'
      end

      it 'one argument given' do
	@driver.execute_command 'PLACE 0'
      end

      it 'four arguments given' do
	@driver.execute_command 'PLACE 0,0,0,0'
      end
    end
  end

  context 'whitespace in a command is handled correctly,' do
    it '(leading and trailing)' do
      expect(@robot).to receive(:move)
      @driver.execute_command "\t\n MOVE\n\t "
    end

    it '(whitespace in arguments)' do
      expect(@robot).to receive(:place)
      @driver.execute_command "PLACE 0,\t0\t,\n   NORTH"
    end
  end

  context "#execute_command 'REPORT'" do
    it 'converts non-nil returned value of robot#report to a string' do
      allow(@robot).to receive(:report) { 42 }
      expect(@driver.execute_command 'REPORT').to eq '42'
    end

    it 'returns nil if robot#report returns nil' do
      allow(@robot).to receive(:report) { nil }
      expect(@driver.execute_command 'REPORT').to eq nil
    end
  end
end
