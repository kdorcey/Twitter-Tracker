class SearchTwitterhandle  < ActiveRecord::Base
  belongs_to :search
  belongs_to :twitterhandle

  validates :search, :presence => true
  validates_associated :search

  validates :twitterhandle, :presence => true
  validates_associated :twitterhandle

end
