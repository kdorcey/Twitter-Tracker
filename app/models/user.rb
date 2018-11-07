require 'bcrypt'

class User < ActiveRecord::Base

  has_many :searches, :dependent => :destroy

  include BCrypt

  def self.create_user!(hash_of_user)
    message = ["username exists!", "email exists!", "Invalid Username!", "Invalid Email!"]

    if username_exists?(hash_of_user[:user_name])
      return false, message[0]
    elsif email_exists?(hash_of_user[:email])
      return false, message[1]
    elsif !(username_is_valid?(hash_of_user[:user_name]))
      return false, message[2]
    elsif !(email_is_valid?(hash_of_user[:email]))
      return false, message[3]
    else
      hash_of_user[:session_token] = SecureRandom.base64
      hash_of_user[:password] = BCrypt::Password.create(hash_of_user[:password])
      User.create!(hash_of_user)
      return true, "ah"
    end
  end


  def self.username_exists?(username)
    User.exists?(user_name: username)
  end
  def self.email_exists?(email)
    User.exists?(email: email)
  end


  def self.username_is_valid?(username)
    #Regex from https://stackoverflow.com/questions/12018245/regular-expression-to-validate-username
    if (username.rindex(/^(?=.{3,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$/) == nil)
      return false
    else
      true
    end
  end


  def self.email_is_valid?(email)
    if (email.rindex(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i) == nil)
      return false
    else
      true
    end
  end



end
