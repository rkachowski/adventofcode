require 'json'
input = File.read "input"

def sum_str str
 str.scan(/-?\d+/).map(&:to_i).reduce(:+)
end

puts sum_str input

class Hash
  def iterate &b
      self.each do |k,v|
        v.iterate(&b) if v.is_a?(Hash) or v.is_a?(Array)
        k.iterate(&b) if k.is_a?(Hash) or k.is_a?(Array)
        yield(self, k, v)
      end
  end
end
class Array
  def iterate &b
      self.each do |k|
        k.iterate(&b) if k.is_a?(Hash) or k.is_a?(Array)
        yield(self, k, nil)
      end
  end
end

obj = JSON.parse input

obj.iterate do |hsh, k, v|
  hsh.clear if hsh.is_a?(Hash) and hsh.value? "red"
end

puts sum_str(obj.to_json)
