TWO_MINUTES = 120
THREE_MINUTES = 180

class Device
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
    return Time.now - THREE_MINUTES if rand < 0.50

    Time.now
  end

  def to_s
    "#Device name:#{@name} status:#{@status}"
  end
end

DEVICES = (0...10).to_a.map { |i| Device.new(name: "Device ##{i}") }

