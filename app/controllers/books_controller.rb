class BooksController < ApplicationController

  def index
    @user = current_user

    @books =Book.all

    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = [@book]
    @user = @book.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end


 
  def update
    @book = Book.find(params[:id])
    @book.update(user_params)
    redirect_to book_path(@book.id)
  end



  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
    redirect_to books_path
    end
  end
end
