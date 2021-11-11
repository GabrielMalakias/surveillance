TWO_MINUTES = 120
THREE_MINUTES = 180

class Person
  STATES = %w(out_of_range offline online)

  def initialize(name:)
    @name = name
    @status = 'online'
  end

  def move_to(status)
    case status
    when *STATES
      puts "Moving #{self} to #{status}"
      @status = status
    else
      puts "Invalid move"
    end
  end

  def is?(status)
    @status == status
  end

  def no_recent_location_received?
    location_received_at < Time.now - TWO_MINUTES
  end

  def location_received_at
    return Time.now - THREE_MINUTES if rand < 0.03

    Time.now
  end

  def to_s
    "#Person name:#{@name} status:#{@status}"
  end
end

POPULATION = (0...10).to_a.map { |i| Person.new(name: "Person ##{i}") }

class RunCheck
  def call
    filter_online.each do |person|
      puts person
      person.move_to('offline') if person.is?('out_of_range')
      person.move_to('out_of_range') if person.no_recent_location_received?
    end
  end

  private

  def filter_online
    POPULATION.reject { |person| person.is?('offline') }
  end
end

check = RunCheck.new
while true
  check.()
  sleep(10)
end
