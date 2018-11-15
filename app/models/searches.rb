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

    date_suffix = from[0,8]
    from_int = from[-2,2].to_i
    to_int = to[-2,2].to_i
    date_vals = {}
    total_count = 0
    #I'm dumb and got my prefixes and suffixes confused. Just flip them (ie: prefixes are at the end)
    # Stop being dumb.
    #   Love, Markus.
    # Initialize the hash
    for i in from_int..to_int do
      prefix = i.to_s
      if prefix.size != 2
        prefix = "0"+prefix
      end

      date_vals[date_suffix+prefix] = 0
    end

    #counts tweets
    client.search("to:#{query}", result_type: "recent", since: from).each do |tweet|
      tweet_date = tweet.created_at.to_s[0,10]
      #makes sure the date is within the desired range
      if date_vals.key?(tweet_date)
        total_count += 1
        date_vals[tweet_date] += 1
      end
    end

    #[{"date" => "yyyy-mm-dd", "value" => y_value}, ...]
    #formatting for levy
    to_return = []
    date_vals.each do |date, count|
      to_return<<{"date"=> date, "value"=>count}
    end

    return total_count, to_return
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
