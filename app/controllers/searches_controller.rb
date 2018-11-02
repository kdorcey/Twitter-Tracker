class SearchesController < ApplicationController

  before_filter 'set_current_user'

  def searches_params
    params.require(:searches).permit(:search_term, :time)
  end

  def index

  end

  def create
    now = DateTime.now
    year = now.year.to_s
    day = now.day.to_s
    month = now.month.to_s
    date = year + '-' + month + '-' + day
    @count = Searches.gather_tweets(searches_params[:search_term].to_s, '2018-10-31', date)
    flash[:notice] = "Number of Tweets that match search parameters: #{@count}"
    redirect_to searches_path
  end

end
