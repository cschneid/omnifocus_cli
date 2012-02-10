module Presenters
  class ListPresenter
    attr_accessor :root
    def initialize(items)
      @items = items
    end

    def display(&block)
      @items.map do |item|
        yield(item)
      end.join("\n")
    end
  end
end
