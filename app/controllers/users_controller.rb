class UsersController < ApplicationController

  before_filter :set_current_user


  def user_params
    params.require(:user).permit(:user_name, :email, :session_token, :password, :country)
  end


  def show
    redir = true

    if @current_user.nil?
      flash[:notice] = "Must be logged in to view a profile page!"
      redirect_to root_path and return
    end

    #needs to be broken up so we can show either the current users profile, or their friends profile.
    if (params[:id].to_s != @current_user.id.to_s)

      user_friends = User.get_user_friends_and_ids(@current_user.user_name)

      user_friends_ids = user_friends[1]


      user_friends_ids_to_string = user_friends_ids.map(&:to_s)
      if user_friends_ids_to_string.include?(params[:id].to_s)
        @user_saved_topics = Searches.where(user_id: params[:id].to_s).where(saved:true)

        friend_info = User.find_by(id: params[:id])
        @user_friend_name = friend_info.user_name

        @graph_data = User.get_history(params[:id].to_s)

        redir = false
      else
        flash[:notice] = "cannot view that profile page!"
        redirect_to root_path and return #redirect doesn't exit the method call: so, need to also return
      end

    end

    if redir
    if (params[:id].to_s == @current_user.id.to_s) #have to do to_s.
      @user_saved_topics = Searches.where(user_id: @current_user.id).where(saved: true)

      @search_hashes = []

      if !@user_saved_topics.empty?
      @user_saved_topics.each do |search|
        curr_user_id = search.user_id
        curr_search_term = search.search_term
        curr_twitter_handle = search.twitter_handle
        curr_from_date = search.from_date
        curr_to_date = search.to_date
        curr_num_tweets = search.number_of_tweets
        curr_graph_data = search.graph_data

        curr_search_hash = {user_id: curr_user_id, search_term: curr_search_term.to_s,
                            twitter_handle: curr_twitter_handle.to_s, from_date: curr_from_date,
                            to_date: curr_to_date, number_of_tweets: curr_num_tweets,
                            graph_data: curr_graph_data } #mo lines mo money

        @search_hashes.push(curr_search_hash)
      end
      end

      #array of search hashes.
      @graph_data = User.get_history(@current_user.id)

      @user_friends = @current_user.friends_list
      @user_friends_ids = User.get_user_friends_and_ids(@current_user.user_name)[1]

      @at_users_home = true

    #This else executes for both if statements. (don't put a redirect in the previous if statement)
    else
        flash[:notice] = "can't view that profile page!"
        redirect_to root_path
    end
    end

  end


  def index
  end

  def add_friend
    #just renders the add friend page
  end

  def verify_add_friend

    if User.exists?(user_name: params[:user_name])

      if @current_user.friends_list.include?(params[:user_name])
        flash[:notice] = "You already have that person as a friend."
        redirect_to :controller => 'users', :action => 'add_friend'
      else
      @current_user.friends_list.push(params[:user_name])
      @current_user.save!
      redirect_to :controller => 'searches', :action => 'index'
      end

    else
      flash[:notice] = "User Does not exist! Imaginary friends aren't allowed, sorry." #Todo:: y this no show?
      redirect_to :controller => 'users', :action => 'add_friend'
    end
  end

  def new
    #this just renders the sign up page.
  end

  #when the button is clicked in new.html.haml, info routes to this method.
  def create
    password = user_params[:password]
    verify_password = params[:verify_password][0]     #params[:verify_password] returns an array so take the first index of array
    user_params[:country] = params[:country] #set users country.
    input_params = user_params
    input_params[:country] = params[:country]

    if password == verify_password
    created_user, message = User.create_user!(input_params)
      if created_user
        flash[:notice] = "New Account Created! Welcome, " + user_params[:user_name] + " - Enjoy your stay. :D"
        redirect_to :controller => 'sessions', :action => 'new'
      else
        flash[:notice] = message
        redirect_to :controller => 'users', :action => 'new'
      end
    else
      flash[:notice] = "Passwords do not match!"
      redirect_to :controller => 'users', :action => 'new'
    end
  end

  def update_country
    @current_user.country = params[:country]
    @current_user.save!
    redirect_to :controller => 'users', :action => 'show'
  end

  #def edit
  #  @user = User.find params[:id]
  #end

  # def update
  #   @movie = Movie.find params[:id]
  ##   @movie.update_attributes!(movie_params)
  #  flash[:notice] = "#{@movie.title} was successfully updated."
  #  redirect_to movie_path(@movie)
  # end

  def destroy
    #   @movie = Movie.find(params[:id])
    #   @movie.destroy
    #   flash[:notice] = "Movie '#{@movie.title}' deleted."
  end

end
