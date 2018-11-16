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

  def self.gather_tweets(query, search_user, from, to)
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
    client.search("to:#{search_user} #{query}", since: from).each do |tweet|
      tweet_date = tweet.created_at.in_time_zone('Central Time (US & Canada)').to_s[0,10]
      puts tweet_date
      #makes sure the date is within the desired range
      if date_vals.key?(tweet_date)
        total_count += 1
        date_vals[tweet_date] += 1
      end
    end
    puts date_vals

    #[{"date" => "yyyy-mm-dd", "value" => y_value}, ...]
    #formatting for levy
    to_return = []
    date_vals.each do |date, count|
      to_return<<{"date"=> date, "value"=>count}
    end

    return total_count, to_return
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
