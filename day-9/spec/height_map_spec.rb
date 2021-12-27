require_relative "../height_map"

example_height_map = <<END
2199943210
3987894921
9856789892
8767896789
9899965678
END

describe HeightMap do
    
    it "initializes from a string" do
        height_map = described_class.new(example_height_map)
        expect(height_map.size).to eq([10, 5])
    end

    it "finds low points" do
        height_map = described_class.new(example_height_map)
        expect(height_map.low_point_values).to eq([1,0,5,5])
    end
end