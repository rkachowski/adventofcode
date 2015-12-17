containers = File.readlines("input").map {|line| line.to_i}
fitting = []
containers.length.times do |t|
  fitting.concat(containers.permutation(t+1).to_a.select { |p| p.reduce(:+) == 150  })
end
puts fitting.count
