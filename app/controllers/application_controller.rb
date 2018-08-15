class ApplicationController < ActionController::Base
  include Clearance::Controller 
 
  def require_moderator
    unless current_user.moderator? || current_user.admin?
      flash[:error] = "You must be a moderator to access previous section"
      redirect_to root_path # halts request cycle
    end
  end

end
