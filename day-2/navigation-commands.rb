Position = Struct.new(:horizontal, :depth)

class Command
  def initialize(amount)
    @amount = amount
  end

  def execute(position)
  end
end

class ForwardCommand < Command
  def execute(position)
    position.horizontal += @amount
  end
end

class DownCommand < Command
  def execute(position)
    position.depth += @amount
  end
end

class UpCommand < Command
  def execute(position)
    position.depth -= @amount
  end
end

def command_for_input(input_line)
  case input_line
  when /forward (\d+)/
    ForwardCommand.new($1.to_i)
  when /down (\d+)/
    DownCommand.new($1.to_i)
  when /up (\d+)/
    UpCommand.new($1.to_i)
  end
end

position = Position.new(0, 0)

ARGF.each_line do |line|
  command = command_for_input(line)
  next if command.nil?
  command.execute(position)
end

puts position.inspect
