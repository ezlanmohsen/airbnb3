class PaymentJob < ApplicationJob
  queue_as :default

  def perform(customer,reservation, listing, amount_paid)
    # ReservationMailer.payment_made_email(customer,reservation, listing, amount_paid).deliver_later(wait: 10.second)
    ReservationMailer.payment_made_email(customer,reservation, listing, amount_paid).deliver

  end
end
