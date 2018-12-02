require 'bcrypt'

class User < ActiveRecord::Base

  has_many :searches, :dependent => :destroy

  serialize :friends_list #friends list is an array.

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


  #Returns user friends list and corresponding ID's if available. If not, returns 2 empty array.
  def self.get_user_friends_and_ids(user_name)
    #check if user exists
    if User.exists?(user_name: user_name)
      user = User.find_by_user_name(user_name)
      friends_list = user.friends_list

      friends_list_ids = Array.new

      #need to check for nil at all?
      friends_list.each do |friend|
        curr_user = User.find_by_user_name(friend)
        friends_list_ids.push(curr_user.id)
      end

      return friends_list, friends_list_ids
    else
      return [], [] #return empty array
    end
  end

  #checks our DB if we have the user, updates info as well.
  # Got this code from a tutorial pretty much.
  def self.find_or_create_from_auth_hash(auth)
    where(provider: auth.provider, session_token: auth.uid).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.session_token = auth.uid #Todo :: check if this is ok (and change above if not)
        user.user_name = auth.info.email
        user.email = auth.info.email
        user.save!
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
    search_ids = Array.new

    if User.exists?(id: user_id)
    user_history = Searches.where(user_id: user_id)
   # test = Searches.joins(:graph_data).where(user_id: user_id)

    if !user_history.empty? #if user has searches
    user_history.each do |user_search|

      curr_graph = user_search.graph_data            #TODO:: use serialize instead of eval.
      curr_graph_as_array_of_hash = eval(curr_graph) #convert string to array of hashes
      final_hash.push(curr_graph_as_array_of_hash)

      search_ids.push(user_search.id)
    end
    end
    end
    return final_hash, search_ids
  end

end
