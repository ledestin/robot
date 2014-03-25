require 'open3'
require './robot'
require './direction'

describe 'robot executable' do
  xit 'processes input commands and prints output' do
    input = <<-EOF
      PLACE 0,0,NORTH
      MOVE
      REPORT

      RIGHT
      MOVE
      REPORT

      LEFT
      MOVE
      REPORT
    EOF
    output = <<EOF
0,1,NORTH
1,1,EAST
1,2,NORTH
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
	subject.execute_command "PLACE #{Robot.table.width},0,NORTH"
	expect(subject.execute_command('REPORT')).to be_nil
      end

      it '(y coordinate is outside table)' do
	subject.execute_command "PLACE 0,#{Robot.table.height},NORTH"
	expect(subject.execute_command('REPORT')).to be_nil
      end
    end
  end

  context 'command MOVE' do
    it 'increases x by 1 when moving facing east' do
      subject.execute_command 'PLACE 0,0,EAST'
      subject.execute_command 'MOVE'
      expect(subject.execute_command('REPORT')).to eq '1,0,EAST'
    end

    it 'increases y by 1 when moving facing north' do
      subject.execute_command 'PLACE 0,0,NORTH'
      subject.execute_command 'MOVE'
      expect(subject.execute_command('REPORT')).to eq '0,1,NORTH'
    end

    it 'decreases x by 1 when moving facing west' do
      subject.execute_command 'PLACE 1,0,WEST'
      subject.execute_command 'MOVE'
      expect(subject.execute_command('REPORT')).to eq '0,0,WEST'
    end

    it 'decreases y by 1 when moving facing south' do
      subject.execute_command 'PLACE 0,1,SOUTH'
      subject.execute_command 'MOVE'
      expect(subject.execute_command('REPORT')).to eq '0,0,SOUTH'
    end

    context 'is ignored if it would get robot outside of the table' do
      it '(going north)' do
	coords = "0,#{Robot.table.height - 1},NORTH"
	subject.execute_command "PLACE #{coords}"
	subject.execute_command 'MOVE'
	expect(subject.execute_command('REPORT')).to eq coords
      end

      it '(going south)' do
	coords = "0,0,SOUTH"
	subject.execute_command "PLACE #{coords}"
	subject.execute_command 'MOVE'
	expect(subject.execute_command('REPORT')).to eq coords
      end

      it '(going east)' do
	coords = "#{Robot.table.width - 1},0,EAST"
	subject.execute_command "PLACE #{coords}"
	subject.execute_command 'MOVE'
	expect(subject.execute_command('REPORT')).to eq coords
      end

      it '(going west)' do
	coords = "0,0,WEST"
	subject.execute_command "PLACE #{coords}"
	subject.execute_command 'MOVE'
	expect(subject.execute_command('REPORT')).to eq coords
      end
    end
  end
end
