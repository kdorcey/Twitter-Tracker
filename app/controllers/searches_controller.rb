class SearchesController < ApplicationController

  before_filter 'set_current_user'

  def searches_params
    params.require(:searches).permit(:search_term, :time)
  end

  def index

  end

  def create
    # Not Finished - Need to implement month end cases
    now = DateTime.now
    year = now.year.to_s
    day = now.day.to_s
    month = now.month.to_s
    date = year + '-' + month + '-' + day
    from_day = now.day - params[:time].to_i
    from_date = year + '-' + month + '-' + '0' + from_day.to_s
    @count = Searches.gather_tweets(searches_params[:search_term].to_s, from_date, date)
    flash[:notice] = "Number of Tweets that match search parameters: #{@count}"
    redirect_to searches_path
  end

end
