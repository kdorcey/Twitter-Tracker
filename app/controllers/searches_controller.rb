class SearchesController < ApplicationController

  before_filter :set_current_user

  def searches_params
    params.require(:searches).permit(:search_term, :time)
  end

  def user_search
    @current_search =Searches.last
  end

  def index
    @user_searches = {}
    @user_searches = Searches.update_table
  end

  def create
    # Not Finished - Need to implement month end cases
    puts "QUIACK"
    puts searches_params[:search_term].to_s.blank?
    if searches_params[:search_term].to_s.blank?
      flash[:notice] = "please enter search term"
      redirect_to searches_path
    else
      if @current_user != nil
        now = DateTime.now
        year = now.year.to_s
        day = now.day.to_s
        month = now.month.to_s
        date = year + '-' + month + '-' + day
        from_day = now.day - params[:time].to_i
        from_date = year + '-' + month + '-' + '0' + from_day.to_s
        @count = Searches.gather_tweets(searches_params[:search_term].to_s, from_date, date)
        search_hash = {}
        search_hash[:user_id] = @current_user.id
        search_hash[:search_term] = searches_params[:search_term].to_s
        search_hash[:from_date] = from_date
        search_hash[:to_date] = date
        search_hash[:number_of_tweets] = @count

        Searches.create_search!(search_hash)
        redirect_to searches_path
      else
        flash[:notice] = "Nah homie, gotta make an account first."
        redirect_to root_path
      end
    end

  def destroy

  end

  end
end

