
def distance speed, duration, rest, seconds
  iter = duration + rest
  cycles = seconds / iter
  remainder = seconds % iter
  remainder = duration if remainder > duration

  speed * duration * cycles + speed * remainder
end
