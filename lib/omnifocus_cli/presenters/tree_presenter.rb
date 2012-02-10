module Presenters
  class TreePresenter
    attr_accessor :root
    def initialize(root=Omnifocus::Root.new.document, callback)
      @root = root
    end

    def display(nesting_method, print_method=:name)
      __display(@root, nesting_method, print_method, 0).join("\n")
    end

    def __display(node, nesting_method, print_method, nesting_level)
      children = node.send(nesting_method)
      [print_node(node, print_method, nesting_level)] + children.map { |child| __display(child, nesting_method, print_method, (nesting_level + 2)) }
    end

    def print_node(node, print_method, nesting_level)
      spaces = " " * nesting_level
      spaces + node.send(print_method)
    end
  end
end
