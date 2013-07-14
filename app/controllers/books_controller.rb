class BooksController < ApplicationController
   def index
   end

   def new
      @book = Book.new
   end

   def create
      @book = Book.new(params[:book])

      if @book.save
         flash[:notice] = "Book has been added"
         redirect_to @book
      else

      end
   end

   def show
      @project = Book.find(params[:id])
   end
end
