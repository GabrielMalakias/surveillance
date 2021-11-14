require_relative 'device'

class SequentialCheck
  def call
    filter_online.each do |device|
      puts device
      device.move_to('offline') if device.is?('out_of_range')
      device.move_to('out_of_range') if device.no_recent_location_received?
    end
  end

  private

  def filter_online
    DEVICES.reject { |device| device.is?('offline') }
  end
end

check = SequentialCheck.new
while true
  check.()
  sleep(10)
end
