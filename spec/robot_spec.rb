require 'open3'
require './robot'
require './direction'

describe 'robot executable' do
  xit 'processes input commands and prints output' do
    input = <<-EOF
      PLACE 0,0,NORTH
      MOVE
      REPORT
    EOF
    output = <<EOF
0,1,NORTH
EOF
    expect(Open3.capture2e('./robot', stdin_data: input).first).to eq output
  end
end

describe Robot do
  context 'command PLACE' do
    Robot::Direction::ALL.each { |direction|
      it "0,0,#{direction} places robot" do
	subject.execute_command "PLACE 0,0,#{direction}"
	expect(subject.execute_command("REPORT")).to eq "0,0,#{direction}"
      end
    }

    context 'is ignored when given invalid' do
      it 'x' do
	subject.execute_command 'PLACE a,0,NORTH'
	expect(subject.execute_command('REPORT')).to be_nil
      end

      it 'y' do
	subject.execute_command 'PLACE 0,a,NORTH'
	expect(subject.execute_command('REPORT')).to be_nil
      end

      it 'direction' do
	subject.execute_command 'PLACE 0,0,NOOP'
	expect(subject.execute_command('REPORT')).to be_nil
      end
    end

    context 'is ignored when placing robot outside table' do
      it '(x coordinate is outside table)' do
	x = Robot::TABLE_WIDTH + 1
	subject.execute_command "PLACE #{x},0,NORTH"
	expect(subject.execute_command('REPORT')).to be_nil
      end

      it '(y coordinate is outside table)' do
	y = Robot::TABLE_HEIGHT + 1
	subject.execute_command "PLACE 0,#{y},NORTH"
	expect(subject.execute_command('REPORT')).to be_nil
      end
    end
  end
end
