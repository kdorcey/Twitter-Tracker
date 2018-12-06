class SearchesController < ApplicationController

  before_filter :set_current_user

  def searches_params
    params.require(:searches).permit(:search_term, :search_user, :time)
  end

  def user_search
    @current_search = Search.find_by(user_id: @current_user.id)
  end

  def index
    @user_saved_topics = {}
    @user_searches = {}
    @top_searches = {}
    if !@current_user.nil?
      @user_searches = Search.get_searches(@current_user)
    end
    # @top_searches = Searches.where(country: @current_user.country).group(:search_term).order('count(*) DESC').limit(10)
    # @top_searches = Searches.where(country: @current_user.country).group(:search_term).limit(10)
    # @top_searches = Searches.where(country: @current_user.country).limit(10)

  end

  def save_topic
    if !@current_user.nil?
      to_save = @current_user.current_search
      if !to_save.nil?
        #to_save.update(saved: true)
        #to_save.user_id = @current_use
        @current_user.search_user.create(search_id: to_save)
      end


      Search.get_searches(@current_user)

      redirect_to root_path #Todo:: change this back to user path whene the JS is working properly.

      # redirect_to user_path(@current_user.id)
    else
      flash[:notice] = "You are not logged in"
      redirect_to searches_path
    end
  end

  def create
    # Not Finished - Need to implement month end cases

    all_twitter_handles = [searches_params[:search_user]]
    params['searches'].keys.each do |field_name|
      if field_name.include? "extra_handle"
        all_twitter_handles.push params['searches'][field_name]
      end
    end


    if searches_params[:search_term].to_s.blank?
      flash[:notice] = "Please enter a search term"
      redirect_to searches_path
    else
      new_search = nil
      if @current_user != nil
        now = Date.today
        from_date = now - params[:time].to_i

        #Used to store all the search hashes for each twitter handle
        all_hashes = Array.new

        #For every twitter handle entry, gather all of the tweets and put the data into the search hash
        all_twitter_handles.each do |handle|
          total_count, graph_data = Search.gather_tweets(searches_params[:search_term].to_s, handle, from_date.to_s, now.to_s, params[:time].to_i)

          #All of the information of the search stored into a hash
          search_hash = {user_id: @current_user.id, search_term: searches_params[:search_term].to_s,
                         twitter_handle: searches_params[:search_user].to_s, from_date: from_date,
                         to_date: now, number_of_tweets: total_count, graph_data: graph_data}

          all_hashes.push search_hash
          new_search = Search.create_search!(search_hash, all_twitter_handles)

          @current_user.current_search = new_search.id #Set users current search to the search they just made
          @current_user.save

        end





        redirect_to searches_display_path
      else
        flash[:notice] = "Nah homie, gotta make an account first."
        redirect_to root_path
      end
    end

    def destroy

    end

    def display
      if !@current_user.current_search.nil?
        @curr_view_search = Search.find_by_id(@current_user.current_search)
      else
        flash[:notice] = "Hmm - Looks like you don't have any search..."
      end
      # @user_searches = Searches.update_table
    end

  end
end

