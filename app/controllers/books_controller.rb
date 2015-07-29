class BooksController < ApplicationController
  before_action :set_book, only: [:show, :read, :finish]

  def entry
    @recently_read_book = Book.order('updated_at').last
    if @recently_read_book
      redirect_to @recently_read_book
    else
      redirect_to books_path
    end
  end

  def index
    @books = Book.where(user: current_user, finished: false).order(updated_at: :desc)
    @finished_books = Book.where(user: current_user, finished: true).order(updated_at: :desc)
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

    if @book.save
      flash[:notice] = 'Book has been added'
      redirect_to @book
    else

    end
  end

  def show
    @graph_data = @book.bookmarks.map { |b| [b.created_at , b.page]}
    render @book.finished? ? :show_finished : :show
  end

  def finish
    @book.finished = true
    @book.save
    redirect_to @book
  end

  def update
    @book = Book.find(params[:id])
    @book.update_attributes(book_params)
    @book.bookmarks.create(page: @book.current_page )
    redirect_to @book
  end

  private
  def book_params
    params.require(:book).permit(:title, :pages, :current_page, :kindle)
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
