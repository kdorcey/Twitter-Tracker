class User < ActiveRecord::Base

  #*
  #def self.create_user!(hashofuser)
    ##Make sure input is capable of being cast to a string (though it is a textfield so it shouldn't matter...)
  #  if !(hashofuser[:user_name].respond_to?(:to_str) || hashofuser[:email].respond_to?(:to_str))
  #    return nil
  #  end

  #  hashofuser[:session_token] = SecureRandom.base64
  #  User.create!(hashofuser)
  #end

  def self.create_user(hashofuser)
    if (hashofuser[:user_name].rindex(/^(?=.{3,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$/) == nil)
      #invalid username
      return 1
    elsif (hashofuser[:email].rindex(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i) == nil)
      #invalid email
      return 2
    elsif(User.exists?(user_name: hashofuser[:user_name]))
      #username already exists
      return 3
    elsif(User.exists?(email: hashofuser[:email]))
      #email already exists
      return 4
    else
      #valid
      hashofuser[:session_token] = SecureRandom.base64
      User.create!(hashofuser)
      return 0
    end
  end
end
