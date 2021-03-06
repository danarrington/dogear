# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show read finish reopen]
  before_action :authenticate

  def entry
    @recently_read_book = Book.order('updated_at').last
    if @recently_read_book
      redirect_to @recently_read_book
    else
      redirect_to books_path
    end
  end

  def index
    @books = Book.where(user: current_user, finished: false)
                 .order(updated_at: :desc)
    @finished_books = Book.grouped_by_year_for(current_user)
    @stats = {
      total_pages: Stats.total_pages(current_user),
      finished_books: Stats.finished_books(current_user)
    }
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.started_at = Date.today
    @book.current_page = 0
    @book.user = current_user

    return unless @book.save

    flash[:notice] = 'Book has been added'
    redirect_to @book
  end

  def show
    @graph_data = @book.bookmark_graph_data
    render @book.finished? ? :show_finished : :show
  end

  def update
    @book = Book.find(params[:id])
    unless @book.update(book_params)
      # TODO: Add validation messaging
      return
    end

    @book.bookmarks.create(page: @book.current_page)
    redirect_to @book
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :current_page, :kindle, :finished)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def authenticate
    redirect_to root_path unless current_user
  end
end
