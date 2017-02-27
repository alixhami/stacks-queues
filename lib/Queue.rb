module CSFun
  class Queue
    def initialize
      @store = Array.new
    end

    def enqueue(element)
      @store << element
    end

    def dequeue
      raise ArgumentError.new("Queue is empty.") if empty?
      @store.delete_at(0)
    end

    def front
      raise ArgumentError.new("Queue is empty.") if empty?
      @store.first
    end

    def size
      @store.length
    end

    def empty?
      size == 0
    end

    def to_s
      @store.to_s
    end
  end
end
