class UsersController < ApplicationController


  def user_params
    params.require(:user).permit(:user_id, :email, :session_token)
  end


  def new
    # default: render 'new' template
  end

  def create
    # test = User.find params[:id]
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts params[:user_id]
    puts params[:email]
    puts "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"


    #redirect_to users_home_url
  end

  def home
    puts "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
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
