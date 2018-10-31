class SessionsController < ApplicationController

  def sessions_params
    params.require(:user).permit(:user_name, :session_token, :password)
  end

  def new

  end

  def create

    user_logged_in = Session.verify_login(sessions_params)

    if user_logged_in.nil?
      flash[:notice] = "Invalid username/password combination."
      redirect_to :controller => 'sessions', :action => 'new'
    else
      session[:session_token] = user_logged_in
      flash[:notice]  = "You are logged in as " + sessions_params[:user_name]
      redirect_to :controller => 'users', :action => 'show'
    end
  end

  def destroy
    @current_user = nil
    session[:session_token] = nil
    flash[:notice] = "successful logout"
    redirect_to searches_main_path
  end

end
