require 'digest'
secret = "bgvyzdsv"

winner = 1
digested = secret + winner.to_s


while digested.index("000000") != 0 do
  winner = winner + 1
  digested = Digest::MD5.hexdigest secret+winner.to_s
end

puts "winner #{winner}"

