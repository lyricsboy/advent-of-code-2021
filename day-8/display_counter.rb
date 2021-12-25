class DisplayCounter
    attr_reader :raw_output_values
    attr_reader :raw_signal_patterns
    attr_reader :decoded_signal_patterns

#     0:      1:      2:      3:      4:
#     aaaa    ....    aaaa    aaaa    ....
#    b    c  .    c  .    c  .    c  b    c
#    b    c  .    c  .    c  .    c  b    c
#     ....    ....    dddd    dddd    dddd
#    e    f  .    f  e    .  .    f  .    f
#    e    f  .    f  e    .  .    f  .    f
#     gggg    ....    gggg    gggg    ....
   
#      5:      6:      7:      8:      9:
#     aaaa    aaaa    aaaa    aaaa    aaaa
#    b    .  b    .  .    c  b    c  b    c
#    b    .  b    .  .    c  b    c  b    c
#     dddd    dddd    ....    dddd    dddd
#    .    f  e    f  .    f  e    f  .    f
#    .    f  e    f  .    f  e    f  .    f
#     gggg    gggg    ....    gggg    gggg

    def initialize(input_line)
        signal_patterns, output = input_line.split("|").map(&:strip)
        @raw_signal_patterns = signal_patterns.split(/\s+/)
        @raw_output_values = output.split(/\s+/) 
        all_chars = "abcdefg".chars       
        @segment_possible_values_map = {
            "a" => all_chars,
            "b" => all_chars,
            "c" => all_chars,
            "d" => all_chars,
            "e" => all_chars,
            "f" => all_chars,
            "g" => all_chars,
        }
        @decoded_signal_patterns = decode_signal_patterns
    end

    def decoded_output_values
        @raw_output_values.map do |raw_value|
            analyze_raw_value(raw_value)
        end
    end

    def decoded_output_value
        decoded_output_values.map(&:to_s).join.to_i
    end

    private

    def analyze_raw_value(raw_value)
        analyzed_value = case raw_value.length
        when 2
            intersect_possible_values(["c", "f"], raw_value.chars)
            1
        when 4
            intersect_possible_values(["b", "c", "d", "f"], raw_value.chars)
            4
        when 3
            intersect_possible_values(["a", "c", "f"], raw_value.chars)
            7
        when 5
            # it's either 2, 3, 5
            # all have a, d, g lit
            intersect_possible_values(["a", "d", "g"], raw_value.chars)
            if known_segment_present?("e", raw_value)
                # it's a 2
                intersect_possible_values(["c", "e"], raw_value.chars)
                2
            elsif known_segment_present?("b", raw_value)
                # it's a 5
                intersect_possible_values(["b", "f"], raw_value.chars)
                5
            elsif known_segment_present?("f", raw_value)
                # could be 3 or 5
                if known_segment_not_present?("b", raw_value)
                    # it's 3
                    intersect_possible_values(["c", "f"], raw_value.chars)
                    3
                elsif known_segment_not_present?("c", raw_value)
                    # it's 5
                    intersect_possible_values(["b", "f"], raw_value.chars)
                    5
                else
                    -1
                end
            else
                -1
            end
        when 6
            # it's either 0, 6, 9
            # all have a, b, f, g lit
            intersect_possible_values(["a", "b", "f", "g"], raw_value.chars)
            if known_segment_not_present?("d", raw_value)
                # it's a 0
                intersect_possible_values(["c", "e"], raw_value.chars)
                0
            elsif known_segment_present?("d", raw_value)
                # it's either 6 or 9
                if known_segment_present?("e", raw_value)
                    # it's a 6
                    intersect_possible_values(["d", "e"], raw_value.chars)
                    6
                elsif known_segment_present?("c", raw_value)
                    # it's a 9
                    intersect_possible_values(["c", "d"], raw_value.chars)
                    9
                else
                    -1
                end
            else
                -1
            end
        when 7
            # don't think we can deduce anything from this since all segments are on
            8
        else
            -1
        end
        analyzed_value
    end

    def known_segment_present?(segment, raw_value)
        @segment_possible_values_map[segment].size == 1 && raw_value.include?(@segment_possible_values_map[segment].first)
    end

    def known_segment_not_present?(segment, raw_value)
        @segment_possible_values_map[segment].size == 1 && !raw_value.include?(@segment_possible_values_map[segment].first)
    end

    def intersect_possible_values(known_segments, possible_segments)
        known_segments.each do |segment|
            @segment_possible_values_map[segment] = @segment_possible_values_map[segment].intersection(possible_segments)
        end
    end

    def decode_signal_patterns
        result = [-1]
        while result.include?(-1)
            result = @raw_signal_patterns.map do |raw_value|
                analyze_raw_value(raw_value)
            end
            # for each known value, remove that value from other possible values 
            known_segments, unknown_segments = @segment_possible_values_map.keys.partition do |segment|
                @segment_possible_values_map[segment].size == 1
            end
            known_segment_values = known_segments.map { |segment| @segment_possible_values_map[segment].first }
            unknown_segments.each do |unknown_segment|
                @segment_possible_values_map[unknown_segment] = @segment_possible_values_map[unknown_segment] - known_segment_values
            end
        end
        result
    end
end