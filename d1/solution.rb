f = File.read "input"
f.chomp

puts "floor = #{f.count('(') - f.count(')')}"
pos = [0,0]

f.each_char{ |c| if c == '(' then pos[0] = pos[0] + 1 else pos[0] = pos[0] - 1 end; pos[1] = pos[1] + 1; break if pos[0] == -1 }
puts "basement at pos #{pos[1]}"
