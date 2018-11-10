class Searches < ActiveRecord::Base

  belongs_to :user

  def self.create_search!(hash_of_search)
    search = Searches.create!(hash_of_search)
  end

  #this probably needs some security
  def self.get_saved

  end

  def self.test_functionality
    client = Searches.authenticate
    client.update("I'm tweeting with ABC!")
  end

  def self.gather_tweets(query, from, to)
    client = Searches.authenticate
    count = 0
    number_of_tweets = client.search("#{query} since:#{from}", :lang => 'en').take(1000).collect
    number_of_tweets.each do
      count += 1
    end
    date_hash = Hash.new
    from_day = from[-2] + from[-1]
    to_day = to[-2] + to[-1]
    from_day_int = from_day.to_i
    to_day_int = to_day.to_i
    day = to_day_int
    while day != from_day_int
      date_hash[day] = 0
      day -= 1
    end
    puts date_hash
    number_of_tweets.each do |tweet|
      asdf = tweet.created_at.to_s
      puts asdf
      day = asdf[8] + asdf[9]
      day2 = day.to_i
      int_tweets = date_hash[day2].to_i
      total = int_tweets + 1
      date_hash[day2] = total
    end

    puts date_hash

    return count, date_hash
  end

  def self.tweets_for_graph(query, from, to)
    client = Searches.authenticate
    tweets = client.search("#{query} since:#{from} until:#{to}", :lang => 'en').take(40).collect
    date_hash = {}
    from_day = from[-2] + from[-1]
    to_day = to[-2] + to[-1]
    from_day_int = from_day.to_i
    to_day_int = to_day.to_i
    day = from_day_int
    while day != to_day_int
      date_hash[day] = 0
      day -= 1
    end
    tweets.each do |tweet|
      asdf = tweet.created_at
      day = asdf[8] + asdf[9]
      day2 = day.to_i
      date_hash[day2] += 1
    end

    puts date_hash
  end

  def self.update_table()
    table_hash = {}
    table_hash = Searches.all
    return table_hash
  end

  private
  def self.authenticate
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "BKUQOAPpOGTOA7kS7aLu758Bw"
      config.consumer_secret     = "loTYyHeloeEadjoQLijip7cYXUWNo5i3AhwOAdIka8b7qU3aem"
      config.access_token        = "2752186016-JKCzA3qh57MXCqokxG4D50AuLrxNh6EjNzluR7V"
      config.access_token_secret = "1f0zBiZMkiRwTRa210XQtRPHw1dSiGbMGnfezNQU1pbgF"
    end
    return client
  end
end
