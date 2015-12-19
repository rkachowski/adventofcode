initial_grid = File.readlines("input").map do |line|
  line.chomp.chars.map{|c| c == "#" ? 1 : 0}
end

def valid_position grid, position=[-1,-1]
  position[0] >= 0 && position[0] < grid.length &&
  position[1] >= 0 && position[1] < grid[0].length
end

def neighbour_sum grid, position=[-1,-1]
  positions = []
  (position[0]-1..position[0]+1).each do |x|
    (position[1]-1..position[1]+1).each do |y|
      positions << [x,y]
    end
  end

  valid_positions = positions.select{ |p| p != position && valid_position(grid, p)}
  valid_positions.map{|p| grid[p[0]][p[1]]}.reduce(:+)
end

def iterate grid, corners=false
  next_grid = grid.each_with_index.map do |arr, row|
    arr.each_with_index.map do |val,col|
      if val == 1
        [2,3].include?(neighbour_sum(grid, [row,col])) ? 1 : 0
      else
        neighbour_sum(grid, [row,col]) == 3 ? 1 : 0
      end
    end
  end
  set_corners next_grid if corners

  next_grid
end

def set_corners grid
  grid[0][0] = 1
  grid[99][0] = 1
  grid[99][99] = 1
  grid[0][99] = 1
end

def print_grid grid
  s = grid.map {|g| g.map {|i| i == 1 ? "#" : "."}}
  s.each {|c| puts c.join }
end

grid = initial_grid
100.times do |j| 
  grid = iterate(grid)
  puts j
end

puts "part1"
puts grid.reduce(0){ |sum,g| sum + g.count(1) }

grid = initial_grid
set_corners grid
100.times do |j| 
  grid = iterate(grid,true)
  puts j
end
puts "part2"
puts grid.reduce(0){ |sum,g| sum + g.count(1) }
