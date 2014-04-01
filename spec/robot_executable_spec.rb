require 'open3'

def execute_commands input
  Open3.capture2e('./robot', stdin_data: input).first
end

describe 'robot executable' do
  it 'handles all possible input commands and prints output' do
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
    expect(execute_commands input).to eq output
  end

  xit 'ignores all moving commands after it was placed outside of table' do
    output = execute_commands <<-EOF
      PLACE -1,0,NORTH
      REPORT
      MOVE
      REPORT
      LEFT
      REPORT
      RIGHT
      REPORT
    EOF

    expect(output).to eq ''
  end
end

