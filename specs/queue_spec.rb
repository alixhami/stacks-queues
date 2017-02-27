require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/queue'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Test Queue Implementation" do
  before do
    @q = CSFun::Queue.new
  end

  it "creates a Queue" do
    @q.class.must_equal CSFun::Queue
  end

  it "adds something to an empty Queue" do
    @q.enqueue(10)
    @q.to_s.must_equal "[10]"
  end

  it "adds multiple somethings to a Queue" do
    @q.enqueue(10)
    @q.enqueue(20)
    @q.enqueue(30)
    @q.to_s.must_equal "[10, 20, 30]"
  end

  it "starts the size of a Queue at 0" do
    @q.size.must_equal 0
    @q.empty?.must_equal true
  end

  it "removes something from the Queue" do
    @q.enqueue(5)
    removed = @q.dequeue
    removed.must_equal 5
    @q.size.must_equal 0
    @q.empty?.must_equal true
  end

  it "removes the right something (FIFO)" do
    @q.enqueue(5)
    @q.enqueue(3)
    @q.enqueue(7)
    removed = @q.dequeue
    removed.must_equal 5
    @q.size.must_equal 2
    @q.to_s.must_equal "[3, 7]"
  end

  it "properly adjusts the size with enqueueing and dequeueing" do
    @q.empty?.must_equal true
    @q.enqueue(-1)
    @q.enqueue(-60)
    @q.size.must_equal 2
    @q.empty?.must_equal false
    @q.dequeue
    @q.size.must_equal 1
    @q.dequeue
    @q.size.must_equal 0
    @q.empty?.must_equal true
  end

  it "returns the front element in the Queue" do
    @q.enqueue(40)
    @q.enqueue(22)
    @q.front.must_equal 40
    @q.enqueue(3)
    @q.dequeue
    @q.front.must_equal 22
  end

  it "doesn't alter the size when you call front" do
    @q.enqueue(5)
    @q.enqueue(10)
    @q.front
    @q.size.must_equal 2
  end

  it "raises an error if you try to dequeue from an empty Queue" do
    proc { @q.dequeue }.must_raise ArgumentError
  end

  it "raises an error if you try to call front on an empty Queue" do
    proc { @q.front }.must_raise ArgumentError
  end

end
