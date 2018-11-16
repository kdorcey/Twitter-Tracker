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

  def self.get_history(user_id)
    final_hash = Array.new
    if User.exists?(id: user_id)
    user_history = Searches.where(user_id: user_id)

   # test = Searches.joins(:graph_data).where(user_id: user_id)

  #  puts test

    if !user_history.empty? #if user has searches
    user_history.each do |user_search|

      curr_graph = user_search.graph_data            #TODO:: use serialize instead of eval.
      curr_graph_as_array_of_hash = eval(curr_graph) #convert string to array of hashes
      final_hash.push(curr_graph_as_array_of_hash)

    end

    end
    end
    return final_hash
  end

end
