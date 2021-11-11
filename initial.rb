TWO_MINUTES = 120
THREE_MINUTES = 180

class Person
  def initialize(name:)
    @name =
  end

  def move_to(status)
    case status
    when 'out_of_range'
      puts "Moving #{self} to out_of_range"
    when 'offline'
      puts "Moving #{self} to offline"
    else
      puts "Invalid move"
    end
  end

  def out_of_range?
    location_received_at < Time.now - TWO_MINUTES
  end

  def location_received_at
    Time.now - THREE_MINUTES if rand < 0.03

    Time.now
  end

  def to_s
    "Person #{@name} last location received at #{@location_received_at}"
  end
end
