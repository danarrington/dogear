class BooksController < ApplicationController
   def index
      @recently_read_book = Book.order('updated_at').last
      if @recently_read_book
        redirect_to @recently_read_book
      else
        redirect_to list_book_path
      end
   end

   def list
      @books = Book.all
   end

   def new
      @book = Book.new
   end

   def create
      @book = Book.new(book_params)
      @book.started_at = Date.today

      if @book.save
         flash[:notice] = 'Book has been added'
         redirect_to @book
      else

      end
   end

   def show
      @book = Book.find(params[:id])
   end

   def read
      @book = Book.find(params[:id])
   end

   def update
      @book = Book.find(params[:id])
      @book.update_attributes(book_params)
      @book.bookmarks.create(page: @book.current_page )
      redirect_to @book
   end

  private
    def book_params
      params.require(:book).permit(:title, :pages, :current_page)
    end

end
