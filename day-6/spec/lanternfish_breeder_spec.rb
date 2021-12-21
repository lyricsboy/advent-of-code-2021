require_relative "../lanternfish_breeder"

describe LanternfishBreeder do

  let(:sample_ages) { [3,4,3,1,2] }
  let(:subject) { LanternfishBreeder.new(sample_ages) }

  it "breeds the first two days" do
    subject.breed
    expect(subject.fish_count).to eq(5)
    subject.breed
    expect(subject.fish_count).to eq(6)
  end

  it "breeds 18 days correctly" do
    18.times { subject.breed }
    expect(subject.fish_count).to eq(26)
  end

  it "breeds 80 days correctly" do
    80.times { subject.breed }
    expect(subject.fish_count).to eq(5934)
  end

  it "breeds 256 days correctly" do
    256.times { subject.breed }
    expect(subject.fish_count).to eq(26984457539)
  end
end