require './state'

describe Robot::State do
  it 'handles conversion to String' do
    state = Robot::State.new 0, 0, 'NORTH'
    expect(state.to_s).to eq '0,0,NORTH'
  end
end
