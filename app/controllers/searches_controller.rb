class SearchesController < ApplicationController

  before_filter :set_current_user

  def searches_params
    params.require(:searches).permit(:search_term, :search_user, :search_from, :search_to)
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
    #levy's multiple handles thing
    all_twitter_handles = [searches_params[:search_user]]




    params['searches'].keys.each do |field_name|
      if field_name.include? "extra_handle"
        all_twitter_handles.push params['searches'][field_name]
      end
    end

    #check that there is a search term
    if searches_params[:search_term].to_s.blank? || searches_params[:search_user].to_s.blank?
      flash[:notice] = "Please enter a search term & a twitter handle!"
      redirect_to searches_path

    elsif searches_params[:search_from].empty? || searches_params[:search_to].empty?
      flash[:notice] = "Enter both dates"
      redirect_to searches_path

    elsif Date.parse(searches_params[:search_from]) > Date.parse(searches_params[:search_to]) || Date.parse(searches_params[:search_from]) > Date.today || Date.parse(searches_params[:search_to]) > Date.today
      flash[:notice] = "Date entered incorrectly!"
      redirect_to searches_path
    else
      search_from = Date.parse(searches_params[:search_from])
      search_to = Date.parse(searches_params[:search_to])
      #logic for running a search
      if !@current_user.nil?
        search_hash = {user_id: @current_user.id, search_term: searches_params[:search_term].to_s, from_date: search_from,
                       to_date: search_to}

        handles_to_link = Twitterhandle.create_twitterhandle!(all_twitter_handles)
        new_search = Search.create_search!(search_hash)

        #Gathers data for each handle, I feel like this loop should be handled by the model buuuutttt o well
        handles_to_link.each do |handle|
          #links search with handle


          total_count, graph_stuff = Search.gather_tweets(searches_params[:search_term], handle, search_from.to_s, search_to.to_s, search_to - search_from)

          new_search.search_twitterhandle.create(twitterhandle_id: handle.id, graph_data: graph_stuff, number_of_tweets: total_count)

        end

        @current_user.current_search = new_search.id
        @current_user.save
        redirect_to searches_display_path


      else
        flash[:notice] = "Nah homie, gotta make an account first."
        redirect_to root_path
      end

    end
  end


  def destroy

  end

  def display
    if !@current_user.current_search.nil?
      #@curr_view_search = Search.find_by_id(@current_user.current_search)
      @curr_view_search = Search.make_for_graph(@current_user)

      #@curr_view_search[:sth_obj] = data_holder[0]
      #@curr_view_search[:handle_holder] = handle_holderz

    else
      flash[:notice] = "Hmm - Looks like you don't have any search..."
    end
    # @user_searches = Searches.update_table
  end

end


