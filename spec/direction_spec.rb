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
    it 'of NORTH returns EAST' do
      expect(Robot::Direction::NORTH.next).to eq Robot::Direction::EAST
    end

    it 'of EAST returns SOUTH' do
      expect(Robot::Direction::EAST.next).to eq Robot::Direction::SOUTH
    end
  end
end
