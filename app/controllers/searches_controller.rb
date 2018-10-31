class SearchesController < ApplicationController

  before_filter 'set_current_user'

  def searches_params
    params.require(:searches).permit(:search_term, :time)
  end

  def index

  end

  def create
    @count = Searches.gather_tweets(searches_params[:search_term], DateTime.today - searches_params[:time], DateTime.today)
  end

end
