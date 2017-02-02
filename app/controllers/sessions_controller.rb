class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email(params[:signin][:email].strip.downcase)

    if user && user.authenticate(params[:signin][:password])
      sign_in_user(user, params[:signin][:remember_me])
      redirect_to root_url, notice: 'Signed in successfully'
    else
      flash[:error] = 'Sorry.'
      render :new
    end
  end

  def destroy
    sign_out_user
    flash[:notice] = "Signed out successfully."
    redirect_to action: :new
  end

end
