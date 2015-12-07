require 'pry'
$input = File.read "input"

$gates = {}
$gates["AND"] = ->(x,y){x & y}
$gates["OR"] = ->(x,y){x | y}
$gates["LSHIFT"] = ->(x,y){x << y}
$gates["RSHIFT"] = ->(x,y){x >> y}
$gates["NOT"] = ->(x,_){~x}
$gates[""] = ->(x,_){x}

$wires = {}

class String
  def integer?
    Integer(self)
    return true
  rescue ArgumentError
    return false
  end
end

class Wire
  attr_accessor :name, :input1, :input2, :func, :result

  def calculate
    return unless has_value?
    return if @result

    input1 = get_param @input1
    input2 = get_param(@input2) if @input2

    @result = @func.call input1, input2
  end

  def has_value?
    if @input2
      get_param(@input1) and get_param(@input2)
    else
      get_param(@input1)
    end
  end

  def inspect
    "[name - #{@name}, input1 - #{@input1}, input2 - #{@input2}, result - #{@result}]"
  end

  private 
  def get_param input
    if input.is_a?(String) and input.integer?
      input.to_i
    else
      unless $wires[input]
        binding.pry
      end
      $wires[input].result
    end
  end
end

def setup_wires
  $input.each_line do |l|
    wire = Wire.new
    components = l.split("->")
    wire.name = components.last.strip
    input_and_func = components.first.split " "

    case input_and_func.count
    when 3
      wire.func = $gates[input_and_func[1]]
      wire.input1 = input_and_func[0]
      wire.input2 = input_and_func[2]
    when 2
      wire.func = $gates["NOT"]
      wire.input1 = input_and_func[1]
    when 1
      wire.func = $gates[""]
      wire.input1 = input_and_func[0]
    end

    $wires[wire.name] = wire unless wire.input1 == nil
  end
end

puts "----- part 1-----"
setup_wires
while($wires.values.any? {|w| w.result == nil}) do
  $wires.values.each { |wire| wire.calculate}
end

puts $wires["a"].inspect

puts "----- part 2-----"
b_value = $wires["a"].result
$wires = {}
setup_wires
$wires["b"].input1 = b_value.to_s

while($wires.values.any? {|w| w.result == nil}) do
  $wires.values.each { |wire| wire.calculate}
end


puts $wires["a"].inspect
