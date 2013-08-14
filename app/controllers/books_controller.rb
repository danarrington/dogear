class BooksController < ApplicationController
   def index
      @books = Book.all
   end

   def new
      @book = Book.new
   end

   def create
      @book = Book.new(params[:book])

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
      @book.update_attributes(params[:book])
      redirect_to @book
   end

end
