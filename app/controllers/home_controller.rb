class HomeController < ApplicationController
  def index
    if current_user
      current_book = Book.where(user: current_user).order(updated_at: :desc).first
      redirect_to current_book if current_book
    else
      render :index
    end

  end
end
