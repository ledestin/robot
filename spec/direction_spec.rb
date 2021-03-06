require 'spec_helper'
require './lib/direction'

describe Robot::Direction do
  %w(NORTH EAST SOUTH WEST).each { |direction|
    it "Direction() succesfully accepts #{direction}" do
      expect { Direction(direction) }.not_to raise_error
    end

    it "constructor succesfully accepts #{direction}" do
      expect { Robot::Direction.new direction }.not_to raise_error
    end
  }

  it 'Direction() raises ArgumentError if passed unknown direction' do
    expect { Direction('INVALID') }.to raise_error ArgumentError
  end

  it 'Direction.new raises ArgumentError if passed unknown direction' do
    expect { Robot::Direction.new('INVALID') }.to raise_error ArgumentError
  end

  direction_states = [
    [Robot::Direction::NORTH, Robot::Direction::EAST],
    [Robot::Direction::EAST, Robot::Direction::SOUTH],
    [Robot::Direction::SOUTH, Robot::Direction::WEST],
    [Robot::Direction::WEST, Robot::Direction::NORTH]
  ]
  context '#next' do
    direction_states.each { |from, to|
      it "of #{from} returns #{to}" do
	expect(from.next).to eq to
      end
    }
  end

  context '#prev' do
    direction_states.each { |to, from|
      it "of #{from} returns #{to}" do
	expect(from.prev).to eq to
      end
    }
  end

  it '#next! replaces self with direction, returned by #next' do
    expect(Direction('NORTH').next!).to eq Robot::Direction::NORTH.next
  end

  it '#prev! replaces self with direction, returned by #prev' do
    expect(Direction('NORTH').prev!).to eq Robot::Direction::NORTH.prev
  end

  context 'Direction constants raise exception on' do
    it '#next!' do
      Robot::Direction::ALL.each { |direction|
	expect { direction.next! }.to raise_error
      }
    end

    it '#prev!' do
      Robot::Direction::ALL.each { |direction|
	expect { direction.prev! }.to raise_error
      }
    end
  end

  it '#to_s returns string representing direction' do
    expect(Robot::Direction::NORTH.to_s).to eq 'NORTH'
  end
end
