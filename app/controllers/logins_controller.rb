class LoginsController < ApplicationController
  def create
    if user = User.authenticate(params[:username])
      # Save the user ID in the session so it can be used in
      # subsequent requests
      session[:current_user_id] = user.id
      redirect_to root_url
    end
  end

  def destroy
    # Remove the user id from the session
    session.delete(:current_user_id)
    flash[:notice] = "You have successfully logged out."
    # Clear the memoized current user
    @_current_user = nil
    redirect_to root_url, status: :see_other
  end
end
