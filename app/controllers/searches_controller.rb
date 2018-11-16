class SearchesController < ApplicationController

  before_filter :set_current_user

  def searches_params
    params.require(:searches).permit(:search_term, :time)
  end

  def user_search
    @current_search = Searches.find_by(user_id: @current_user.id)
  end

  def top_search
    @top_searches = Searches.group(:search_term).order('count_id DESC').limit(10).count(:id)
    puts 'hello'
    puts @top_searches
  end

  def index
    @user_saved_topics = {}
    @user_searches = {}
    @top_searches = {}
    @user_searches = Searches.update_table
    @top_searches = Searches.where(country: @current_user.country).group(:search_term).order('count(*) DESC').limit(10)
  end

  def save_topic
    if !@current_user.nil?
      to_save = Searches.update_table.last
      to_save.update(saved: true)
      Searches.update_table

      redirect_to user_path(@current_user.id)
    else
      flash[:notice] = "You are not logged in"
      redirect_to searches_path
    end
  end

  def create
    # Not Finished - Need to implement month end cases

    if searches_params[:search_term].to_s.blank?
      flash[:notice] = "please enter search term"
      redirect_to searches_path
    else
      if @current_user != nil
        now = Date.today
        from_date = now - params[:time].to_i
        total_count, graph_data = Searches.gather_tweets(searches_params[:search_term].to_s, from_date.to_s, now.to_s)
        search_hash = {}
        search_hash[:user_id] = @current_user.id
        search_hash[:search_term] = searches_params[:search_term].to_s
        search_hash[:from_date] = from_date
        search_hash[:to_date] = now
        search_hash[:number_of_tweets] = total_count
        search_hash[:country] = @current_user.country
       # search_hash[:saved] = false

        search_hash[:graph_data] = graph_data
        new_search = Searches.create_search!(search_hash)

        search_hash[:graph_data] = graph_data.to_json

        @current_user.current_search=new_search.id #Set users current search to the search they just made
        @current_user.save

        redirect_to searches_display_path(:search_hash => search_hash)
      else
        flash[:notice] = "Nah homie, gotta make an account first."
        redirect_to root_path
      end
    end

  def destroy

  end

  def display
    @search_info = params[:search_hash]
    @graph_data = @search_info[:graph_data]
    if !@current_user.current_search.nil?
    @curr_view_search = Searches.find_by_id(@current_user.current_search)
    else
      flash[:notice] = "Hmm - Looks like you don't have any search..."
    end
   # @user_searches = Searches.update_table
  end



end
end

