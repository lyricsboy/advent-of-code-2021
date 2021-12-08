class BinaryNumberReader
  include Enumerable

  def initialize(input_stream)
    @input_stream = input_stream
  end

  def each(&block)
    @input_stream.each_line.map { |line| line.to_i(2) }.map(&block)
  end

end