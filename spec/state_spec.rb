require 'spec_helper'
require './lib/state'

describe Robot::State do
  it 'handles conversion to String' do
    state = Robot::State.new 0, 0, 'NORTH'
    expect(state.to_s).to eq '0,0,NORTH'
  end

  it 'raises State if a constructor argument is invalid' do
    expect { Robot::State.new 'a', 0, 'NORTH' }.to \
      raise_error Robot::StateArgumentError
  end
end
