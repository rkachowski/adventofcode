input = File.read "input"

@visited = ["0,0"]
@position = [0,0]

def handle_gift position, char
  case char
  when "^"
    position[1] = position[1] + 1
  when "v"
    position[1] = position[1] - 1
  when "<"
    position[0] = position[0] - 1
  when ">"
    position[0] = position[0] + 1
  end
  position.join(",")
end

input.each_char { |c| @visited << handle_gift(@position, c)}
puts "unique presents #{@visited.uniq.count}"

@santa = [0,0]
@robo_santa = [0,0]
@visited = []
input.each_char.each_with_index do |c,i| 
  pos = nil
  if i.even? then pos = @santa else pos = @robo_santa end
  @visited << handle_gift(pos, c)
end

puts "unique presents with robo help #{@visited.uniq.count}"

