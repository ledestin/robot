require 'spec_helper'
require './lib/robot'

describe Robot do
  it '#execute_command relays command to driver' do
    command = 'NOOP'
    driver, driver_klass = double(), double()
    driver_klass.stub(:new) { driver }
    expect(driver).to receive(:execute_command).with(command)
    robot = Robot.new driver_klass
    robot.execute_command command
  end

  context '#place' do
    context 'is valid, places robot at' do
      Robot::Direction::ALL.each { |direction|
	it "0,0,#{direction}" do
	  subject.place 0, 0, direction
	  expect(subject.report.to_s).to eq "0,0,#{direction}"
	end
      }
    end

    context 'is ignored when given invalid' do
      it 'x' do
	subject.place 'a', 0, 'NORTH'
	expect(subject.report).to be_nil
      end

      it 'y' do
	subject.place 0, 'a', 'NORTH'
	expect(subject.report).to be_nil
      end

      it 'direction' do
	subject.place 0, 0, 'NOOP'
	expect(subject.report).to be_nil
      end
    end

    context 'is ignored when placing robot outside table' do
      context '(x equals' do
	[Robot.table.width, -1].each do |x|
	  it "#{x})" do
	    subject.place x, 0, 'NORTH'
	    expect(subject.report).to be_nil
	  end
	end
      end

      context '(y equals' do
	[Robot.table.height, -1].each do |y|
	  it "#{y})" do
	    subject.place 0, y, 'NORTH'
	    expect(subject.report).to be_nil
	  end
	end
      end
    end

    it "doesn't change existing state if invalid" do
      subject.place 0, 0, 'NORTH'
      expect(subject.report.to_s).to eq '0,0,NORTH'
      subject.place -1, 0, 'NORTH'
      expect(subject.report.to_s).to eq '0,0,NORTH'
    end
  end

  context '#move' do
    context 'successfully' do
      it 'increases x by 1 when moving facing east' do
	subject.place 0, 0, 'EAST'
	subject.move
	expect(subject.report.to_s).to eq '1,0,EAST'
      end

      it 'increases y by 1 when moving facing north' do
	subject.place 0, 0, 'NORTH'
	subject.move
	expect(subject.report.to_s).to eq '0,1,NORTH'
      end

      it 'decreases x by 1 when moving facing west' do
	subject.place 1, 0, 'WEST'
	subject.move
	expect(subject.report.to_s).to eq '0,0,WEST'
      end

      it 'decreases y by 1 when moving facing south' do
	subject.place 0, 1, 'SOUTH'
	subject.move
	expect(subject.report.to_s).to eq '0,0,SOUTH'
      end
    end

    context 'is ignored if it would get robot outside of the table' do
      it '(going north)' do
	coords = Robot::State.new(0, Robot.table.height - 1, 'NORTH')
	subject.place coords.x, coords.y, coords.direction
	subject.move
	expect(subject.report).to eq coords
      end

      it '(going south)' do
	coords = Robot::State.new(0, 0, 'SOUTH')
	subject.place coords.x, coords.y, coords.direction
	subject.move
	expect(subject.report).to eq coords
      end

      it '(going east)' do
	coords = Robot::State.new(Robot.table.width - 1, 0, 'EAST')
	subject.place coords.x, coords.y, coords.direction
	subject.move
	expect(subject.report).to eq coords
      end

      it '(going west)' do
	coords = Robot::State.new(0, 0, 'WEST')
	subject.place coords.x, coords.y, coords.direction
	subject.move
	expect(subject.report).to eq coords
      end
    end
  end

  context '#left' do
    direction = Direction 'NORTH'
    4.times {
      it "changes direction from #{direction} to #{direction.prev}" do
	subject.place 0, 0, direction
	subject.left
	expect(subject.report.direction).to eq direction.prev!
      end
    }
  end

  context '#right' do
    direction = Direction 'NORTH'
    4.times {
      it "changes direction from #{direction} to #{direction.next}" do
	subject.place 0, 0, direction
	subject.right
	expect(subject.report.direction).to eq direction.next!
      end
    }
  end

  context '#report' do
    it "is nil if robot wasn't placed yet" do
      expect(subject.report).to be_nil
    end

    it 'returns valid state after robot was placed' do
      subject.place 0, 0, 'NORTH'
      expect(subject.report).to eq Robot::State.new(0, 0, 'NORTH')
    end
  end
end
