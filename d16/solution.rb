input = File.read "input"

$sues = input.each_line.map do |line|
  info = line.scan(/([a-z]+: \d)/).flatten.map{|str| str.split(":")}
  info.reduce({}){ |h,sue_info|  h[sue_info[0]] = sue_info[1].to_i; h}
end

clues = <<END
children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1
END
$clues = clues.each_line.map { |line| line.split ":" }

def sueteration
  result = $sues.select do |sue|
    result = true
    $clues.each do |clue| 
      test = yield sue, clue
      result = test if not test.nil?
    end
    result
  end
  $sues.index(result[0])+1 if not result.empty?
end

puts "--- part 1 ---"
result = sueteration do |sue, clue|
  if sue[clue[0]]
    false unless sue[clue[0]] == clue[1].to_i
  end
end
puts result

puts "--- part 2 ---"
result = sueteration do |sue, clue|
  if sue[clue[0]]
    case clue[0]
    when "trees", "cats"
      false unless sue[clue[0]] > clue[1].to_i
    when "pomeranians", "goldfish"
      false unless sue[clue[0]] < clue[1].to_i
    else
      false unless sue[clue[0]] == clue[1].to_i
    end
  end
end
puts result
