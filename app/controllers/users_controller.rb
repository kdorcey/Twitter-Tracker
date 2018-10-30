class UsersController < ApplicationController

  before_filter :set_current_user


  def user_params
    params.require(:user).permit(:user_name, :email, :session_token, :password)
  end

  def show


  end


  def new
    #this just renders the sign up page.
  end

  #when the button is clicked in new.html.haml, info routes to this method.
  def create
    password = user_params[:password]

    #params[:verify_password] returns an array so take the first index of array
    verify_password = params[:verify_password][0]


    if (!User.username_exists?(user_params[:user_name]) && !User.email_exists?(user_params[:email]) && (password == verify_password))
      User.create_user!(user_params)
      redirect_to :controller => 'sessions', :action => 'new'
    else
      redirect_to :controller => 'users', :action => 'new'
    end


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
