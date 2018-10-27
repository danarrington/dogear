# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email.downcase!

    if @user.save
      sign_in_user(@user, false)
      flash[:notice] = 'You have signed up successfully.'
      redirect_to books_path
    else
      render :new
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
