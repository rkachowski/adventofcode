input = File.read "input"

def distance speed, duration, rest, seconds
  iter = duration + rest
  cycles = seconds / iter
  remainder = seconds % iter

  speed * duration * cycles + speed * [remainder, duration].min
end

distances = input.each_line.map do |line|
  speed, duration, rest = line.scan(/(\d+)/).flatten.map(&:to_i)
  distance speed, duration, rest, 2503
end

puts "--- part 1 ---"
puts distances.max

deer = Hash.new {|k,v| k[v] = {}}
input.each_line.map do |line|
  stats = line.scan(/(\d+)/).flatten.map(&:to_i)
  name = line.split(" ").first

  deer[name][:stats] = stats
  deer[name][:points] = 0
end

2503.times do |i|
  round_results = {}
  deer.each { |k,v| round_results[k] = distance *v[:stats], i+1 }
  round_results.each do |k,v|
    deer[k][:points] = deer[k][:points] + 1 if v == round_results.values.max
  end
end

puts "--- part 2 ---"
puts deer.map{|k,v|v[:points]}.max
