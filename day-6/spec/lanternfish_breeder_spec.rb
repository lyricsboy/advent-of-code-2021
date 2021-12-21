require_relative "../lanternfish_breeder"

describe LanternfishBreeder do

  let(:sample_ages) { [3,4,3,1,2] }
  let(:subject) { LanternfishBreeder.new(sample_ages) }

  it "breeds the first two days" do
    subject.breed
    expect(subject.fish_ages).to eq([2,3,2,0,1])
    subject.breed
    expect(subject.fish_ages).to eq([1,2,1,6,0,8])
  end

  it "breeds 18 days correctly" do
    18.times { subject.breed }
    expect(subject.fish_ages).to eq([6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8])
  end

  it "breeds 80 days correctly" do
    80.times { subject.breed }
    expect(subject.fish_ages.count).to eq(5934)
  end
end