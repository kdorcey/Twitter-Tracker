class SessionsController < ApplicationController

  def new

  end

  def create

    redirect_to :controller => 'users', :action => 'show'
  end

  def destroy

  end

end
