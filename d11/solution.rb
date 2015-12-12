def distinct_pairs str
  str.scan(/([a-z])\1/).uniq.length >= 2
end

def incremental_run str
  str.bytes.each_with_index do |b,i|
    return false if i + 3 > str.bytes.length
    return true if str.bytes[i+1] == b + 1 and str.bytes[i+2] == b + 2
  end
end


def valid? password
  return false if password.match(/i|o|l/) or !distinct_pairs(password) or !incremental_run(password)
  true
end

def get_next password
  loop do
    password = password.next
    break if valid? password
  end
  password
end
password = "cqjxjnds"

puts "part 1"
result = get_next(password)
puts result
puts "part 2"
puts get_next(result)

