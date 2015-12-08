input = File.read "input"

stripped = input.each_line.map{|l| l.strip}
code_char_count  = stripped.each.inject(0){|sum,l| sum + l.length}

string_chars = Marshal.load(Marshal.dump(stripped))
string_chars.each do |l|
  l.gsub! %{\\\\},"B"
  l.gsub! %{\\"},"Q"
  l.gsub!(/\\x[\da-fA-F]{2}/, "X")
  l.gsub! '"', ''
end

string_char_count  = string_chars.each.inject(0){|sum,l| sum + l.length}
puts "--- part 1 ---"
puts code_char_count - string_char_count

reencoded = Marshal.load(Marshal.dump(stripped))

puts "-- part 2 -- "

reencoded_count  = reencoded.each.inject(0){|sum,l| sum + l.inspect.length}
puts reencoded_count - code_char_count
