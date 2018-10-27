class User < ActiveRecord::Base

  def self.create_user!(hashofuser)

    ##Make sure input is capable of being cast to a string (though it is a textfield so it shouldn't matter...)
    if !(  hashofuser[:user_name].respond_to?(:to_str) ||  hashofuser[:email].respond_to?(:to_str)  )
      return nil
    end

    name_taken = User.exists?(user_name: hashofuser[:user_name])
    if name_taken
      return nil
    else
      hashofuser[:session_token] = SecureRandom.base64
      User.create!(hashofuser)
    end
  end




end
