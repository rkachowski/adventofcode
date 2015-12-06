input = File.read "input"

lights = []
1000.times do |i|
  lights[i] = Array.new(1000,0)
end

input.each_line do |l|
  coords = l.scan(/([0-9]*,[0-9]*)/).map{|c| c[0].split(",")}
  coords.each{|c| c.map!{|p| p.to_i}}

  lightBlock = -> (b){ b+1}
  case l
  when /off/
    lightBlock = ->(b){ if b > 0 then b-1 else 0 end}
  when /toggle/
    lightBlock = ->(b){ b+2}
  end

  coords[0][0].upto(coords[1][0]) do |x|
    coords[0][1].upto(coords[1][1]) do |y|
      lights[x][y] = lightBlock.call(lights[x][y] )
    end
  end
end

total_lights = 0
lights.each { |l| total_lights = total_lights +  l.reduce(:+)}

puts "total lights #{total_lights}"
