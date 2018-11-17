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

  def self.gather_tweets(query, search_user, from, now, formatter)
    client = Searches.authenticate

    total_count = 0
    date_vals = {}
    date_vals = format_date_holder(from, now, formatter)


    client.search("to:#{search_user} #{query}", since: from).each do |tweet|
      tweet_date = tweet.created_at.in_time_zone('Central Time (US & Canada)')

      if formatter == 1 || formatter == 2
        tweet_date = tweet_date.to_s[0,13]
        edit = tweet_date.to_s[-2,2].to_i
        if formatter == 1
          tweet_date.slice!(-2,2)
          if edit > 0 && edit < 6
            tweet_date = tweet_date + "00:00:00"
          elsif edit >= 6 && edit < 12
            tweet_date = tweet_date + "06:00:00"
          elsif edit >= 12 && edit < 18
            tweet_date = tweet_date + "12:00:00"
          elsif edit >=18 && edit < 24
            tweet_date = tweet_date + "18:00:00"
          end
        elsif formatter == 2
          tweet_date.slice!(-2,2)
          if edit > 0 && edit < 12
            tweet_date = tweet_date + "00:00:00"
          else
            tweet_date = tweet_date + "12:00:00"
          end
        end
      else
        tweet_date = tweet_date.to_s[0,10]
      end

      #makes sure the date is within the desired range
      if date_vals.key?(tweet_date)
        total_count += 1
        date_vals[tweet_date] += 1
      end
    end

    to_return = []
    date_vals.each do |date, count|
      to_return<<{"date"=> date, "value"=>count}
    end

    puts to_return
    return total_count, to_return
  end

  def self.format_date_holder(from, now, formatter)
    date_vals={}


    if formatter == 1
      date_vals[from+" 00:00:00"] = 0
      date_vals[from+" 12:00:00"] = 0
      date_vals[from+" 18:00:00"] = 0
      date_vals[from+" 23:59:00"] = 0
    elsif formatter == 2
      all_dates = (from..now).map(&:to_s)
      all_dates.each do |key|
        date_vals[key+" 00:00:00"] = 0
        date_vals[key+" 12:00:00"] = 0
      end
    else
      all_dates = (from..now).map(&:to_s)
      all_dates.each do |key|
        date_vals[key] = 0
      end
    end

    return date_vals
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
