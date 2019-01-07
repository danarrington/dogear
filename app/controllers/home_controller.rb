# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    return render :index unless current_user

    current_book = Book.where(user: current_user).order(updated_at: :desc).first
    if current_book
      redirect_to current_book
    else
      redirect_to books_path
    end
  end
end
