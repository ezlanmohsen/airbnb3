class ReservationMailer < ApplicationMailer
	def booking_email(customer, host, reservation_id)
      @host = host
      @customer = customer
      @listing = Listing.find(Reservation.find(reservation_id).listing_id)
      @reservation = Reservation.find(reservation_id)
      mail to: @host.email, Subject: "You have a new booking!"
	end

	def payment_made_email(customer,reservation, listing, amount_paid)
		@customer = customer
		@payment_amount = amount_paid
		@reservation = reservation
		@listing = listing
		@host = @listing.user
		# byebug
		mail to: @customer.email, Subject: "Payment received. Enjoy your stay!"
	end
end
