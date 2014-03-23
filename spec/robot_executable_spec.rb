require 'open3'
require './robot'

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
  it 'command PLACE 0,0,NORTH places robot' do
    subject.execute_command 'PLACE 0,0,NORTH'
    expect(subject.execute_command('REPORT')).to eq '0,0,NORTH'
  end
end
