module CSFun
  class Stack
    def initialize
      @store = Array.new
    end

    def push(element)
      @store << element
    end

    def pop
      raise ArgumentError.new("Stack is empty.") if empty?
      @store.pop
    end

    def top
      raise ArgumentError.new("Stack is empty.") if empty?
      @store.last
    end

    def size
      @store.length
    end

    def empty?
      size == 0
    end

    def to_s
      return @store.to_s
    end
  end
end
