class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @word = params[:word]
    @pattern = params[:pattern]
    
    if @model == "User"
      @records = User.search_for(@pattern, @word)
    else
      @records = Book.search_for(@pattern, @word)
    end  
  end
  
end
