require 'set'

class AcyclicGraph
  attr_accessor :nodes

  def initialize()
    @nodes = {}
  end

  def add_node(node_name)
    return nodes[node_name] if nodes.key?(node_name)
    nodes[node_name] = Node.new(node_name)
  end

  def get_node(node_name)
    nodes[node_name]
  end

  class Node
    attr_accessor :name, :children, :parents

    def initialize(name)
      @name = name
      @children = {}
      @parents = Set.new
    end

    def add_child(node, count)
      raise if children.key?(node.name)

      node.parents.add(self)

      children[node.name] = {
        count: count,
        node: node
      }
    end

    def get_all_parents
      result = Set.new
      @parents.each do |parent|
        result.add(parent)
        result.merge(parent.get_all_parents)
      end
      return result
    end
  end
end

rules = File.read("day7-input").lines
graph = AcyclicGraph.new

rules.map { |rule|
  bag_type, contents = rule.gsub(/ bags?/, '').tr("\n.", '').split(" contain ")
  parent = graph.add_node(bag_type)

  contents.split(', ').each { |content|
    break if content == "no other"
    count, nested_bag_type = content.match(/(\d+) ([\w ]+)/).captures
    child = graph.add_node(nested_bag_type)
    parent.add_child(child, count)
  }
}

puts graph.get_node("shiny gold").get_all_parents.count
