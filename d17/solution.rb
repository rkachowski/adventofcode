containers = File.readlines("input").map {|line| line.to_i}
fitting = containers.length.times.map do |t|
  containers.combination(t+1).to_a.map { |p| p if p.reduce(:+) == 150  }
end
puts fitting.count

min = fitting.map{|f|f.count}.min
puts fitting.select{|p| p.count == min}.count
