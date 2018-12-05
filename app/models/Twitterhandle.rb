class Twitterhandle
  has_many :search, through: :search_twitterhandles
  has_many :search_twitterhandles
end
