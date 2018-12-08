class SearchUser  < ActiveRecord::Base
  belongs_to :search
  belongs_to :user

  validates :search_id, :presence => true
  validates_associated :search

  validates :user_id, :presence => true
  validates_associated :user
end
