require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/job_simulation'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Test Terrible Company" do
  before do
    @sim = JobSimulation.new(6,10)
  end

  it "Starts with workers 1-6 employed, and 7-10 on the waitlist" do
    @sim.working.top.must_equal "Worker #6"  # Next to fire
    @sim.working.size.must_equal 6

    @sim.waiting.front.must_equal "Worker #7"  # Next to hire
    @sim.waiting.size.must_equal 4
  end

  it "Fires the last hired and hires the first in line" do
    proc {
      @sim.cycle(1)
    }.must_output(/Fire Worker #6\nHire Worker #7/)
  end

  it "Fires the last hired and hires the first in line over multiple cycles" do
    6.times do
      next_to_fire = @sim.working.top
      next_to_hire = @sim.waiting.front
      proc {
        @sim.cycle(1)
      }.must_output(/Fire #{next_to_fire}\nHire #{next_to_hire}/)
    end
  end

  it "Matches expected behavior from the README example" do
    proc {
      @sim.cycle(6)
    }.must_output "Managers roll a 6
Fire Worker #6
Fire Worker #5
Fire Worker #4
Fire Worker #3
Fire Worker #2
Fire Worker #1
Hire Worker #7
Hire Worker #8
Hire Worker #9
Hire Worker #10
Hire Worker #6
Hire Worker #5\n"

    proc {
      @sim.cycle(2)
    }.must_output "Managers roll a 2
Fire Worker #5
Fire Worker #6
Hire Worker #4
Hire Worker #3\n"

    proc {
      @sim.cycle(3)
    }.must_output "Managers roll a 3
Fire Worker #3
Fire Worker #4
Fire Worker #10
Hire Worker #2
Hire Worker #1
Hire Worker #5\n"
  end
end
