input = File.read "input"

#cities = input.each_line.map{|l| words = l.split(" "); [words[0],words[2]]}.flatten.uniq

class Node
  attr_accessor :name, :edges
  def initialize name
    @name=name
    @edges = {}
  end
end

class Graph
  attr_reader :nodes

  def initialize
      @nodes = {}
  end

  def get_node name
    unless @nodes[name]
      @nodes[name] = Node.new name
    end
    @nodes[name]
  end

  def add_edge name1, name2, distance
    node1 = get_node name1
    node2 = get_node name2

    node1.edges[name2] = distance
    node2.edges[name1] = distance
  end
end


graph = Graph.new
input.each_line do |line|
  words = line.split(" ")
  graph.add_edge words[0], words[2], words[4].to_i

end

puts graph.nodes
