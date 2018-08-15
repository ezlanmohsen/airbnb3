class ReservationsController < ApplicationController
  def index
  	@reservations = Reservation.all
  end

  def create
  	@reservation = Reservation.new(reservation_params)
  	@reservation.user_id = current_user.id
  	if @reservation.save
  		redirect_to user_path(current_user)
  	else
      # debugger
  		# redirect_to new_reservation_path(:id => @reservation.listing_id) , notice: "Your booking has failed"
      @reservations = Reservation.all
      render 'reservations/index'
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
      reservation_to_approve.approved!
    end
    redirect_back fallback_location: root_path
  end

  def payment
    
  end

  private

  def reservation_params
  	params.require(:reservation).permit!
  end
end

