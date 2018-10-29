class User < ActiveRecord::Base

  def self.create_user!(hashofuser)
    ##Make sure input is capable of being cast to a string (though it is a textfield so it shouldn't matter...)
    if !(hashofuser[:user_name].respond_to?(:to_str) || hashofuser[:email].respond_to?(:to_str))
      return nil
    end

    hashofuser[:session_token] = SecureRandom.base64
    User.create!(hashofuser)
  end

  def self.username_is_valid?(username)
    #Regex from https://stackoverflow.com/questions/12018245/regular-expression-to-validate-username
    if (username.rindex(/^(?=.{3,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$/) == nil)
      return false
    else
      true
    end
  end

  def self.username_exists?(username)
    User.exists?(user_name: username)
  end
  def self.email_exists?(email)
    User.exists?(email: email)
  end

  def self.email_is_valid?(email)
    if (email.rindex(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i) == nil)
      return false
    else
      true
    end
  end




end
