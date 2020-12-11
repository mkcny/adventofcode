require 'set'

class Graph
  def initialize()
    @nodes = {}
  end

  def add_node(node_name)
    return nodes[node_name] if nodes.key?(node_name)
    nodes[node_name] = Node.new(node_name)
  end

  def find(node_name)
    nodes[node_name]
  end

  private

  attr_accessor :nodes

  class Node
    attr_reader :name

    def initialize(name)
      @name = name
      @children = {}
      @parents = Set.new
    end

    def add_parent(node)
      parents.add(node)
    end

    def add_child(node, count)
      raise if children.key?(node.name)
      node.add_parent(self)
      children[node.name] = {count: count, node: node}
    end

    def get_all_parents
      Set.new.tap do |result|
        parents.each do |parent|
          result.add(parent)
          result.merge(parent.get_all_parents)
        end
      end
    end

    private

    attr_accessor :children, :parents
  end
end

rules = File.read("day7-input").lines
graph = Graph.new

rules.map { |rule|
  bag_type, contents = rule.gsub(/ bags?/, '').tr("\n.", '').split(" contain ")
  parent = graph.add_node(bag_type)

  contents.split(', ').each { |content|
    break if content == "no other"
    count, nested_bag_type = content.match(/(\d+) ([\w ]+)/).captures
    parent.add_child(graph.add_node(nested_bag_type), count)
  }
}

part1_result = graph.find("shiny gold").get_all_parents.count
puts "part 1 result: #{part1_result}"
raise "you broke something" unless part1_result == 151
