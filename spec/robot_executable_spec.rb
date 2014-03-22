require 'open3'

describe 'robot executable' do
  it 'processes input commands and prints output' do
    input = <<-EOF
      PLACE 0,0,NORTH
      MOVE
      REPORT
    EOF
    output = <<EOF
0,1,NORTH
EOF

    expect(Open3.capture2e('./robot', input).first).to eq output
  end
end
