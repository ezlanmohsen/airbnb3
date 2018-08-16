class ReservationsController < ApplicationController
  def index
  	@reservations = Reservation.all
  end

  def create
  	@reservation = Reservation.new(reservation_params)
  	@reservation.user_id = current_user.id
  	if @reservation.save
      ReservationMailer.booking_email(current_user, @reservation.listing.user, @reservation.id).deliver
  		redirect_to user_path(current_user)
  	else
      # debugger
  		# redirect_to new_reservation_path(:id => @reservation.listing_id) , notice: "Your booking has failed"
      @reservations = Reservation.all
      render 'reservations', :flash => { :error => "Reservation failed. Please try again." }
    end
  end

  def show
  end

  def new #/listings/:listing_id/reservations/new
  	@listing = Listing.find(params[:listing_id])
  	@reservation = Reservation.new
  end

  #to approve
  def approve # /reservations/:id/approve
    reservation_to_approve = Reservation.find(params[:id])
    if reservation_to_approve.booked?
      reservation_to_approve.accepted!
    end
    redirect_back fallback_location: root_path
  end

  #for braintree
  def payment
    @client_token = Braintree::ClientToken.generate
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:id])
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => Listing.find(params[:listing_id]).min_price, #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    # byebug

    if result.success?

      reservation_to_approve = Reservation.find(params[:id])
      if reservation_to_approve.booked? #fix this later
        reservation_to_approve.paid!
        # byebug
      end
      # byebug
      # mailer
      ReservationMailer.payment_made_email(User.find(reservation_to_approve.user_id), reservation_to_approve, Listing.find(reservation_to_approve.user_id), result.transaction.amount).deliver
      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end

  private

  def reservation_params
  	params.require(:reservation).permit!
  end
end

