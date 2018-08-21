class ListingsController < ApplicationController
  before_action :require_moderator, only: [:verify]


  def index

    @tags = Tag.all

    #refer to method in model
    if params[:reset]
      @listings = Listing.all.paginate(:page => params[:page], :per_page => 10)
    # elsif params[:tag]
    #   @listings = Tag.find(params[:tag]).listings
    elsif params[:search_name]
      @listings = Listing.search(params[:search_name], params[:search_max_price], params[:search_country]).paginate(:page => params[:page], :per_page => 10)
    elsif params[:tag] 
      @listings = Tag.find(params[:tag]).listings.paginate(:page => params[:page], :per_page => 10)
          # byebug
      respond_to do |format|
        format.js #refer views/listings/index/js 
        format.html { redirect_to root_path, notice: 'Your JS AJAX Search failed' } #???
        # format.json
      end
    else
      @listings = Listing.all.paginate(:page => params[:page], :per_page => 10)
   end
    # MOVED TO MODEL
    # if params[:search]
    #   @listings = Listing.where("name LIKE ?", "%#{params[:search]}%").paginate(:page => params[:page], :per_page => 10)
    # else
    #   @listings = Listing.paginate(:page => params[:page], :per_page => 10)
    # end

    #NOTE - FOR INDEX HTML ERB. EQUIVALENT OF FORM TAG.
    # <%= form_for :search, url: root_path, method: :get do |f| %> 
    # <%= f.label :name %>
    # <%= f.text_field :search_name %>
    # <%= f.label :maximum_price %>
    # <%= f.text_field :search_max_price %>
    # <%= f.label :country %> 
    # <%= f.text_field :seach_country %>
    # <%= f.submit %>

    # byebug
  end

  def show
    @listing = Listing.find(params[:id])
    @reservations = Reservation.all
    @listing_tags = ListingTag.where(listing_id: params[:id])
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
