class BookCommentsController < ApplicationController
 
 def create
   @book = Book.find(params[:book_id])
   @comment = current_user.book_comments.create(book_comment_params)
   @comment.book_id = @book.id
   redirect_to request.referer
 end

  def destroy
    @book = Book.find(params[:book_id])
    @comment =　BookComment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end
  
end
