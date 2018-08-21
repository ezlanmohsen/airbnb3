class UsersController < Clearance::UsersController
	 def create
      @user = User.new(user_params)
      if @user.save
        redirect_to user_path(@user)
      else
        redirect_to sign_up_path
      end
    end

    # Page to show user profile. Endpoint for sign in.
    def show
      @user = User.find(params[:id])
      @listing_tags = ListingTag.all
      @tags = Tag.all
      @tag = Tag.new
      # @reservations = Reservation.where(user_id: params[:id])
      if params[:reservation] == "unpaid"
        @reservations = Reservation.unpaid
        respond_to do |format|
          format.js
          format.html {redirect_to user_path(current_user)}
        end
      elsif params[:reservation] == "all"
        @reservations = Reservation.all
        respond_to do |format|
          format.js
          format.html {redirect_to user_path(current_user)}
        end
      else
        @reservations = Reservation.all
      end   
    end
  
      private
  
      def user_params
        params.require(:user).permit(:avatar, :email, :first_name, :last_name, :birthdate, :password)
      end

      def tag_params
        params.require(:tag).permit!
      end


end