class ReservationJob < ApplicationJob
  queue_as :default

  def perform(customer, host, reservation_id)
    # Do something
    ReservationMailer.booking_email(customer, host, reservation_id).deliver_later(wait: 1.minute)
  end
end
