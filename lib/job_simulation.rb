class JobSimulation
  attr_reader :working, :waiting

  def initialize(jobs_available, job_seekers)
    @working = CSFun::Stack.new
    @waiting = CSFun::Queue.new

    job_seekers.times do |i|
      @waiting.enqueue("Worker \##{i + 1}")
    end

    while @working.size != jobs_available
      @working.push( @waiting.dequeue )
    end
  end

  def cycle(num=rand(1..6))
    @roll = num
    puts "Managers roll a #{@roll}"

    @roll.times do
      fired = @working.pop
      puts "Fire #{fired}"
      @waiting.enqueue(fired)
    end

    @roll.times do
      hired = @waiting.dequeue
      puts "Hire #{hired}"
      @working.push(hired)
    end
  end
end

if __FILE__ == $0
  require './lib/Stack'
  require './lib/Queue'

  ## Allows us to run our code and see what's happening:
  sim = JobSimulation.new(6,10)
  puts "------------------------------"
  puts "Before the simulation starts"
  puts "Employed: #{sim.working}"
  puts "Waitlist: #{sim.waiting}"
  puts "------------------------------"
  print "<enter to cycle>\n"

  count = 0
  until gets.chomp != ""
    puts "-------Cycle #{count+=1}-------"
    sim.cycle
    puts "Employed: #{sim.working}"
    puts "Waitlist: #{sim.waiting}"
  end

end
