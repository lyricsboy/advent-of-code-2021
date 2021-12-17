require_relative "../line"

describe Line do
  it "parses from an input line" do
    line = described_class.parse("0,1 -> 100,101")
    expect(line.origin_point.x).to eq(0)
    expect(line.origin_point.y).to eq(1)
    expect(line.destination_point.x).to eq(100)
    expect(line.destination_point.y).to eq(101)
  end

  it "calculates max x and y" do
    line = described_class.parse("0,0 -> 100,100")
    expect(line.max_x).to eq(100)
    expect(line.max_y).to eq(100)
  end

  it "identifies vertical lines" do
    expect(described_class.parse("0,0 -> 0,10").vertical?).to be true
    expect(described_class.parse("1,0 -> 0,1").vertical?).to be false
  end

  it "identifies horizontal lines" do
    expect(described_class.parse("10,0 -> 1,0").horizontal?).to be true
    expect(described_class.parse("1,0 -> 0,1").horizontal?).to be false
  end
end