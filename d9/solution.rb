input = File.read "input"

cities = input.each_line.map{|l| words = l.split(" "); [words[0],words[2]]}.flatten.uniq

graph = {}
input.each_line do |line|
  words = line.split(" ")
  city1, city2, distance = words[0], words[2], words[4].to_i

  graph[city1] ||= {}
  graph[city1][city2] = distance
  graph[city2] ||= {}
  graph[city2][city1] = distance
end

paths = cities.permutation.map{|c| c.join "->"}
distances = {}

paths.each do |path|
  cities_in_path = path.split "->"

  distance = 0
  cities_in_path.each_with_index do |cp,i|
    next if i == 0
    c1, c2 = cities_in_path[i-1], cities_in_path[i]
    distance += graph[c1][c2]
  end
  distances[path] = distance
end

puts "shortest distance #{ distances.values.min} : #{distances.key(distances.values.min)}"
puts "longest distance #{distances.values.max} : #{distances.key(distances.values.max)}"
