import * as fs from 'fs';

class Node {
  name: string
  parents: Map<string, Node> = new Map()
  children: Map<string, Node> = new Map()

  constructor(name: string) {
    this.name = name
  }

  addParent(node: Node): void {
    this.parents.set(node.name, node)
  }

  addChild(node: Node): void {
    this.children.set(node.name, node)
    node.addParent(this)
  }

  getAllParents(): Set<Node> {
    let result: Set<Node> = new Set()
    this.parents.forEach(parent => {
      result.add(parent)
      result = new Set([...parent.getAllParents(), ...result])
    })
    return result
  }
}

class Graph {
  nodes: { [name: string]: Node } = {}

  addNode(name: string): Node {
    const existing = this.nodes[name]
    if (existing !== undefined) {
      return existing
    }
    return this.nodes[name] = new Node(name)
  }

  find(name: string): Node {
    const node = this.nodes[name]
    if (node === undefined) throw new Error("couldn't find that node")
    return node
  }
}

let graph = new Graph()

const lines = fs.readFileSync('../input/day7','utf8')
    .split("\n")

lines.forEach(line => {
  let [bagType, contents] = line.replaceAll(/ bags?/g, '').replaceAll(/[\n\.]/g, '').split(' contain ')
  if (bagType != undefined && contents != undefined) {
    let parent = graph.addNode(bagType)

    contents.split(', ').forEach(content => {
      let matches = content.match(/(?<count>\d+) (?<nested_bag_type>[\w ]+)/)?.groups
      if (matches?.nested_bag_type != undefined) {
        parent.addChild(graph.addNode(matches.nested_bag_type))
      }
    })
  }
})

console.log(graph.find("shiny gold").getAllParents().size)
