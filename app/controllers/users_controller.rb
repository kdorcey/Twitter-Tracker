class UsersController < ApplicationController


  def user_params
    params.require(:user).permit(:user_name, :email, :session_token, :password)
  end

  def show


  end


  def new
    #this just renders the sign up page.
  end

  #when the button is clicked in new.htmlhaml, info routes to this method.
  def create
    puts "OIOIOIOIOIOIOIOIOIOI"
    puts params[:verify_password]
    # use: params[:user_id], params[:email], params[:password], params[:verify_password]

    # if password does not equal verify password
    # redirect to new
    # elseif
    # user id is taken
    # redirect to new
    # else
    # create user
    # redirect to user homepage (for now. redirect to main when implemented.)
    #User.create_user!(user_params)
    if (!User.username_exists?(user_params[:user_name]) && !User.email_exists?(user_params[:email]) && (user_params[:password] == params[:verify_password]))
      User.create_user!(user_params)
      redirect_to :controller => 'users', :action => 'show'
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
