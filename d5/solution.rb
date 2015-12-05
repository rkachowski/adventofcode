require 'pry'
input = File.read "input"

@banned_strings = %w{ ab cd pq xy }

class String
  def indices e
    start, result = -1, []
    result << start while start = (self.index e, start + 1)
    result
  end
end

def valid? str
  @banned_strings.each {|bs| return false if str.index(bs)}
  
  vowel_count = "aeiou".chars.inject(0){|sum,c| sum + str.count(c)}
  return false unless vowel_count > 2

  str.chars.each_with_index { |char,i| return true if str[i-1] == char}
  false
end

valid = 0
input.each_line {|l| valid = valid + 1 if valid?(l)}
puts "nice count #{valid}"

def valid2? str

  pair = false
  str.chars.each_with_index do |c,i|
    next if i == 0 
    sub = str[i-1]+c

    matches = str.indices(/#{sub}/)
    matches.delete i
    matches.delete i-1
    matches.delete i-2

    if matches.count > 0
      pair = true 
      break;
    end
  end
  return false unless pair

  str.chars.each_with_index { |char,i| next unless i > 1; return true if str[i-2] and str[i-2] == char}
  false
end


valid = 0
input.each_line {|l| valid = valid + 1 if valid2?(l)}
puts "new nice count #{valid}"
