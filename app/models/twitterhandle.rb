class Twitterhandle  < ActiveRecord::Base
  has_many :search, through: :search_twitterhandle
  has_many :search_twitterhandle



  def self.create_twitterhandle!(list_of_handles)
    if !list_of_handles.nil?
      ret = []
      list_of_handles.each do |temp|
        temp =Twitterhandle.where(handle: temp).first_or_create

        ret<<temp
      end
      return ret

    end

  end


end
