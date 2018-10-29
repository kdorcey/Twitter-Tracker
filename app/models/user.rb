class User < ActiveRecord::Base

  def self.create_user!(hashofuser)
    ##Make sure input is capable of being cast to a string (though it is a textfield so it shouldn't matter...)
    if !(hashofuser[:user_name].respond_to?(:to_str) || hashofuser[:email].respond_to?(:to_str))
      return nil
    end

    hashofuser[:session_token] = SecureRandom.base64
    User.create!(hashofuser)
  end


  def self.username_exists?(username)
    User.exists?(user_name: username)
  end

  def self.email_exists?(email)
    User.exists?(email: email)
  end


end
