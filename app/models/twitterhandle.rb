class Twitterhandle  < ActiveRecord::Base
  has_many :search, through: :search_twitterhandle
  has_many :search_twitterhandle



  def self.create_twitterhandle!(list_of_handles)
    if !list_of_handles.nil?
      handle_objects = []
      list_of_handles.each do |temp|
        temp =Twitterhandle.where(handle: temp).first_or_create

        handle_objects<<temp
      end
      return handle_objects

    end

  end


end
