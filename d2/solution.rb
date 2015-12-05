input = File.read "input"

def area_for_present present_string
  l, w, h =present_string.split("x").map { |s| s.to_i }
  areas = [l*w,w*h,h*l]
  min = areas.min

  areas.map{|a| a * 2}.reduce(:+) + min
end

total = input.each_line.inject(0){ |sum, line| sum + area_for_present(line) }
puts "paper total sq feet #{total}"

def area_for_ribbon present_string
  dimensions = present_string.split("x").map { |s| s.to_i }
  max = dimensions.max
  dimensions.delete_at(dimensions.index(max))

  wrap_length = dimensions.map{|d|d*2}.reduce(:+)
  bow_length = dimensions[0] * dimensions[1] * max

  wrap_length + bow_length
end

total = input.each_line.inject(0){ |sum, line| sum + area_for_ribbon(line) }
puts "ribbon total sq feet #{total}"
