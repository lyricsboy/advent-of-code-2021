require_relative "../fuel_calculator"

describe FuelCalculator do

  it "calculates example fuel requirements" do
    horizontal_positions = [16,1,2,0,4,2,7,1,2,14]
    subject = described_class.new(horizontal_positions)
    expect(subject.minimum_fuel_requirements).to eq(37)
  end

end