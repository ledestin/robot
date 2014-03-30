require './direction'

describe Robot::Direction do
  %w(NORTH EAST SOUTH WEST).each { |direction|
    it "Direction() succesfully accepts #{direction}" do
      expect { Direction(direction) }.not_to raise_error
    end
  }

  it 'Direction() raises ArgumentError if passed unknown direction' do
    expect { Direction('INVALID') }.to raise_error ArgumentError
  end

  context '#next' do
    [ [Robot::Direction::NORTH, Robot::Direction::EAST],
      [Robot::Direction::EAST, Robot::Direction::SOUTH],
      [Robot::Direction::SOUTH, Robot::Direction::WEST],
      [Robot::Direction::WEST, Robot::Direction::NORTH]
    ].each { |from, to|
      it "of #{from} returns #{to}" do
	expect(from.next).to eq to
      end
    }
  end
end
