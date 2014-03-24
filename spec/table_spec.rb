require './table'

describe Robot::Table do
  before :all do
    @table = Robot::Table.new 5, 5
  end

  context '#inside?' do
    context 'when coords are outside table' do
      it 'returns false (x < 0)' do
	expect(@table.inside?(-1, 0)).to eq false
      end

      it 'returns false (x > table width)' do
	expect(@table.inside?(@table.width + 1, 0)).to eq false
      end

      it 'returns false (y < 0)' do
	expect(@table.inside?(0, -1)).to eq false
      end

      it 'returns false (y > table height)' do
	expect(@table.inside?(0, @table.height + 1)).to eq false
      end
    end

    context 'when coords are inside table' do
      it 'returns true (x is on table border)' do
	expect(@table.inside?(@table.width, 0)).to eq true
      end

      it 'returns true (y is on table border)' do
	expect(@table.inside?(0, @table.height)).to eq true
      end
    end
  end
end
