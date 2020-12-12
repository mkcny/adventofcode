# typed: strict
require 'sorbet-runtime'
require 'set'

extend T::Sig

class Graph
  extend T::Sig

  sig {void}
  def initialize()
    @nodes = T.let({}, T::Hash[String, Node])
  end

  sig {params(node_name: String).returns(Node)}
  def add_node(node_name)
    return nodes.fetch(node_name) if nodes.key?(node_name)
    nodes[node_name] = Node.new(node_name)
  end

  sig {params(node_name: String).returns(Node)}
  def find(node_name)
    nodes.fetch(node_name)
  end

  private

  sig{returns(T::Hash[String, Node])}
  attr_accessor :nodes

  class Node
    extend T::Sig

    sig{returns(String)}
    attr_reader :name

    class AnnotatedChild < T::Struct
      const :count, Integer
      const :node, Node
    end

    sig {params(name: String).void}
    def initialize(name)
      @name = name
      @children = T.let({}, T::Hash[String, AnnotatedChild])
      @parents = T.let(Set.new, T::Set[Node])
    end

    sig {params(node: Node).void}
    def add_parent(node)
      parents.add(node)
    end

    sig {params(node: Node, count: Integer).void}
    def add_child(node, count)
      raise if children.key?(node.name)
      node.add_parent(self)
      children[node.name] = AnnotatedChild.new(count: count, node: node)
    end

    sig {returns(T::Set[Node])}
    def get_all_parents
      Set.new.tap do |result|
        parents.each do |parent|
          result.add(parent)
          result.merge(parent.get_all_parents)
        end
      end
    end

    private

    sig{returns(T::Hash[String, AnnotatedChild])}
    attr_accessor :children

    sig {returns(T::Set[Node])}
    attr_accessor :parents
  end
end

sig {params(rules: T::Array[String]).returns(Graph)}
def parse_rules(rules)
  Graph.new.tap do |graph|
    rules.map do |rule|
      bag_type, contents = rule.gsub(/ bags?/, '').tr("\n.", '').split(" contain ")
      parent = graph.add_node(T.must(bag_type))

      T.must(contents).split(', ').each do |content|
        break if content == "no other"
        count, nested_bag_type = T.must(content.match(/(\d+) ([\w ]+)/)).captures
        parent.add_child(graph.add_node(T.must(nested_bag_type)), T.must(count).to_i)
      end
    end
  end
end

sig {params(graph: Graph).returns(Integer)}
def part_one(graph)
  graph.find("shiny gold").get_all_parents.count
end

if __FILE__ == $0
  rules = File.read("day7-input").lines
  graph = parse_rules(rules)
  puts "part 1 result: #{part_one(graph)}"
end
