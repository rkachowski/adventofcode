input = "1321131112"

class String
  def split_uniq
    chars = self.chars
    indices = chars.each_with_index.map do |c, i|
      next if i == 0
      i-1 if c != chars[i-1]
    end

    indices.compact!
    indices.unshift(-1)
    indices.push chars.length-1

    result = indices.each_with_index.map do |sp, i|
      next if i==0
       chars[((indices[i-1]+1)..sp)]
    end

    result.compact
  end
end

def transform str
  str.length.to_s + str.chars[0]
end

puts "part 1 yo----"
puts 40.times.inject(input){|value,n| puts "#{n} - #{value.length}"; value.split_uniq.map{|s| transform(s.join) }.join }.length
puts "part 2 yo----"
puts 50.times.inject(input){|value,n| puts "#{n} - #{value.length}"; value.split_uniq.map{|s| transform(s.join) }.join }.length
