class User < ActiveRecord::Base

  def self.create_user!(hashofuser)
    puts "aaaaaaaaaahhhhhhhhhhhh"
    puts 'mooooo'
    puts hashofuser[:user_name]
    puts hashofuser[:password]
    puts hashofuser[:email]
    puts hashofuser[:verify_password]
    puts 'mooooo'

    ##Make sure input is capable of being cast to a string (though it is a textfield so it shouldn't matter...)
    if !(  hashofuser[:user_name].respond_to?(:to_str) ||  hashofuser[:email].respond_to?(:to_str)  )
      return nil
    end

    name_taken = User.exists?(user_name: hashofuser[:user_name])
    if name_taken
      return nil
    else
      puts 'mooooo'
      puts hashofuser[:user_name]
      puts hashofuser[:password]
      puts hashofuser[:email]
      puts hashofuser[:verify_password]
      puts 'mooooo'

      hashofuser[:session_token] = SecureRandom.base64
      User.create!(hashofuser)
    end
  end




end
