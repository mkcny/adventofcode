# typed: false
require "minitest/autorun"
require_relative "../day7"

class Day7Tests < Minitest::Test
  def setup
    @graph = Graph.new
  end

  def test_part_one_result
    graph = parse_rules(File.read("input/day7").lines)
    assert_equal 151, part_one(graph)
  end

  def test_part_two_result
    graph = parse_rules(File.read("input/day7").lines)
    assert_equal 41559, part_two(graph)
  end

  def test_part_two_example
    rules = [
      "shiny gold bags contain 2 dark red bags.",
      "dark red bags contain 2 dark orange bags.",
      "dark orange bags contain 2 dark yellow bags.",
      "dark yellow bags contain 2 dark green bags.",
      "dark green bags contain 2 dark blue bags.",
      "dark blue bags contain 2 dark violet bags.",
      "dark violet bags contain no other bags."
    ]
    graph = parse_rules(rules)
    assert_equal 126, part_two(graph)
  end

  def test_adding_a_node
    child_node = @graph.add_node('child_node')

    node = @graph.add_node('test')
    node.add_child(child_node, 1)

    # TODO: don't use send?
    assert @graph.find('test').send(:children).key?('child_node')
    assert @graph.find('child_node').send(:parents).include?(node)
  end

  def test_prevent_duplicate_nodes
    one = @graph.add_node('test')
    two = @graph.add_node('test')
    assert one.equal?(two)
  end

  def test_prevent_adding_the_same_child
    child_node = @graph.add_node('child_node')
    node = @graph.add_node('test')
    node.add_child(child_node, 1)

    assert_raises { node.add_child(child_node, 1) }
  end

  def test_get_all_parents
    node_a = @graph.add_node('a')
    node_b = @graph.add_node('b')
    node_c = @graph.add_node('c')

    node_a.add_child(node_b, 1)
    node_b.add_child(node_c, 1)

    result = node_c.get_all_parents

    assert_equal 2, result.count
    assert result.include?(node_a)
    assert result.include?(node_b)
  end
end
