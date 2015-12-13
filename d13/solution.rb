input = File.read "input"

scores = {}
input.each_line do |line|
  parts = line.split " "
  name, impact, score, name2 = parts[0], parts[2], parts[3].to_i, parts.last.chop
  score = -score if impact == "lose"

  scores[name]||={}
  scores[name][name2] = score
end

def max_happiness scores
  arrangements = scores.keys.permutation.to_a
  happiness = arrangements.map do |seating|
    seating.each_with_index.reduce(0) do |memo, (person,i)| 
      next_index = i+1
      next_index = 0 if next_index >= seating.length
      memo+scores[person][seating[i-1]]+scores[person][seating[next_index]]
    end
  end
  happiness.max
end

puts max_happiness scores

scores.each { |k,v| v["CoolDude"] = 0}
scores["CoolDude"] = Hash.new(0)

puts max_happiness scores
