require_relative "../height_map"

example_height_map = <<END
2199943210
3987894921
9856789892
8767896789
9899965678
END

describe HeightMap do

    let(:height_map) { described_class.new(example_height_map) }
    
    it "initializes from a string" do
        expect(height_map.size).to eq([10, 5])
    end

    it "finds low point coordinates" do
        expect(height_map.low_points).to eq([[0,1], [0, 9], [2, 2], [4, 6]])
    end

    it "finds low point values" do
        expect(height_map.low_point_values).to eq([1,0,5,5])
    end

    it "finds basins of appropriate sizes" do
        expect(height_map.basin_sizes).to eq([3, 9, 14, 9])
    end
end