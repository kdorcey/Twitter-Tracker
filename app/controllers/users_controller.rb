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

    #Logic for users friends page

    if (params[:id].to_s != @current_user.id.to_s)

      user_friends = User.get_user_friends_and_ids(@current_user.user_name)
      user_friends_ids = user_friends[1]

      user_friends_ids_to_string = user_friends_ids.map(&:to_s)
      if user_friends_ids_to_string.include?(params[:id].to_s)

        friend_info = User.find_by(id: params[:id])
        @user_friend_name = friend_info.user_name
        @user_saved_topics = friend_info.search

        @search_hashes = []
        if !@user_saved_topics.empty?
          @user_saved_topics.each do |search|
            @search_hashes.push({id: search.id})
          end
        end

        graph_data, search_ids = User.get_history(params[:id].to_s)
        @history_search_hashes = organize_history_search(search_ids)

        redir = false
      else
        flash[:notice] = "cannot view that profile page!"
        redirect_to root_path and return #redirect doesn't exit the method call: so, need to also return
      end

    end

    ##Logic for users home page.

    if redir
    if (params[:id].to_s == @current_user.id.to_s) #have to do to_s.
      @user_saved_topics = @current_user.search

      ##GRAB saved searches ID info so it can be optionally displayed later.
      @search_hashes = []
      if !@user_saved_topics.empty?
        @user_saved_topics.each do |search|
        @search_hashes.push({id: search.id})
      end
      end

      ##GRAB past 10 search history ID info so it can be optionally displayed later.

      graph_data, search_ids = User.get_history(@current_user.id)
      @history_search_hashes = organize_history_search(search_ids)

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

  ####HELPER methods for show
  def organize_history_search(search_ids)
    history_search_hashes = []
    if !search_ids.empty?
      search_ids = search_ids.reverse #newest searches first
      if search_ids.size > 10
        search_ids = search_ids.take(10)
      end
      search_ids.each do |search|
        history_search_hashes.push({id: search})
      end
    end
    return history_search_hashes
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

  def go_to_search
    @current_user.current_search=params[:search_id]
    @current_user.save!

    if !@current_user.current_search.nil?
      @curr_view_search = Search.find_by_id(@current_user.current_search)
      @curr_view_search.view_count= @curr_view_search.view_count+1
      @curr_view_search.save!
    else
      flash[:notice] = "Hmm - Looks like you don't have any search..."
    end

  end

  def save_topic

    to_save = Search.find_by_id(@current_user.current_search)
    new_record = to_save.dup
    new_record.user_id=@current_user.id
    new_record.update(saved: true)
    new_record.view_count=0
    new_record.save!
    @current_user.search_user.create(search_id: new_record.id)

    redirect_to user_path(:id => @current_user.id)
  end

end
