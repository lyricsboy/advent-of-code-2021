require_relative "../display_counter"

sample_input = <<SAMPLE
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
SAMPLE

other_example = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"

describe DisplayCounter do
    it "initializes from a string" do
        sample = sample_input.split("\n").first
        subject = described_class.new(sample)
        expect(subject.raw_output_values).to eq(["fdgacbe","cefdb","cefbgd","gcbe"])
    end

    it "counts known values in the output" do
        subjects = sample_input.split("\n").map { |line| described_class.new(line) }
        decoded_output_values = subjects.map(&:decoded_output_values)
        known_values = [1,4,7,8]
        known_value_count = decoded_output_values.reduce(0) do |sum, values|
            sum += values.filter { |value| known_values.include?(value) }.count
        end
        expect(known_value_count).to eq(26)
    end

    it "recognizes all values in the input" do
        subject = described_class.new(other_example)
        expect(subject.decoded_signal_patterns).to eq([8,5,2,3,7,9,6,4,0,1])
    end

    it "decodes the output values" do
        subject = described_class.new(other_example)
        subject.decoded_signal_patterns
        expect(subject.decoded_output_values).to eq([5,3,5,3])
        expect(subject.decoded_output_value).to eq(5353)
    end

    it "decodes all the output values" do
        subjects = sample_input.split("\n").map { |line| described_class.new(line) }
        expect(subjects.map(&:decoded_output_value)).to eq([8394,9781,1197,9361,4873,8418,4548,1625,8717,4315])
    end
end