require 'bcrypt'

class Session

  include BCrypt

  def self.verify_login(sessions_params)


    #If successful login, return session token ID. else return nil.
    #
    if User.exists?(user_name: sessions_params[:user_name]) ##make sure user exists.

      user_email_and_session = User.where(user_name: sessions_params[:user_name]).pluck(:session_token, :password)
      user_email_and_session.flatten!

      rehashed_password = BCrypt::Password.new(user_email_and_session[1])

      if rehashed_password == sessions_params[:password]
        return user_email_and_session[0]
      else
        return nil
      end
    end
    return nil
  end


end
