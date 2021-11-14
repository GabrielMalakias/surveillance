require 'sidekiq'
require_relative 'device'

class CheckWorker
  include Sidekiq::Worker

  def perform(index)
    device = DEVICES[index]
    Sidekiq.logger.info(device)

    if device.is?('out_of_range')
      return device.move_to('offline')
    end

    device.move_to('out_of_range') if device.no_recent_location_received?
    CheckWorker.perform_in(10, index)
  end
end

DEVICES.each_with_index do |_device, index|
  CheckWorker.perform_in(10, index)
end
