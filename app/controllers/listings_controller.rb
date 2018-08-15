class ListingsController < ApplicationController
  before_action :require_moderator, only: [:verify]


  def index

  	@user
    @listings = Listing.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @listing = Listing.find(params[:id])
    @reservations = Reservation.all
  end

  def new
  	@listing = Listing.new
  end

  def create
  	@listing = Listing.new(listing_params)
  	@listing.user_id = current_user.id
  	if @listing.save
  		redirect_to user_path(current_user) #redirecting to user profile
  	else
  		render 'new' #reloading listing#new
  	end
  end

  def edit # /listings/:id/edit
    @listing = Listing.find(params[:id])
    # if @listing.update(listing_params)
    #   redirect_to listing_path
    # else
    #   render 'listings/edit'
    # end
  end

  def update 
     @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      redirect_to listing_path
    else
      render 'listings/edit'
    end
  end 

  def destroy
    @listing_delete = Listing.find(params[:id])
    @listing_delete.destroy
    redirect_to user_path(current_user)
  end

  #to verify
  def verify # /listings/:id/verify
    listing_to_verify = Listing.find(params[:id])
    if listing_to_verify.verified?
      listing_to_verify.not_verified!
    else
      listing_to_verify.verified!
    end
    redirect_to listing_path(listing_to_verify)
  end


  private
 
  # def require_admin
  #   unless current_user.admin?
  #     flash[:error] = "You must be an admin to access this section"
  #     redirect_to home_path # halts request cycle
  #   end
  # end

  def listing_params
    params.require(:listing).permit(:name, :description, :address_1, :address_2, :postcode, :state, :country, :bedroom, :bed, :bathroom, :space, :max_guest, :min_price, :max_price, {images: []})
  end

end
