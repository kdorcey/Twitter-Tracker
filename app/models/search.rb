require 'date'
class Search < ActiveRecord::Base

  has_many :search_user
  has_many :user, through: :search_user

  #adds search to the database
  def self.create_search!(hash_of_search)
    search = Search.create!(hash_of_search)
  end

  #primary method for gathering tweets
  def self.gather_tweets(query, search_user, from, now, formatter)
    client = Search.authenticate

    total_count = 0
    date_vals = {}
    #the dates need to be formatted really specifically for the twitter search, this calls the method that does that
    date_vals = format_date_holder(from, now, formatter)


    client.search("from:#{search_user} #{query}", since: from).each do |tweet|
      tweet_date = tweet.created_at.in_time_zone('Central Time (US & Canada)')

      #Method of grabbing the full tweet instead of a truncated version found here:
      # https://stackoverflow.com/questions/47383617/ruby-twitter-retrieving-full-tweet-text
      status = client.status(tweet, tweet_mode: "extended")

      if status.truncated? && status.attrs[:extended_tweet]
        # Streaming API, and REST API default
        full_tweet = status.attrs[:extended_tweet][:full_text]
      else
        # REST API with extended mode, or untruncated text in Streaming API
        full_tweet = status.attrs[:text] || status.attrs[:full_text]
      end

      #ok this parts a little wonky. Basically what's happening here, is deciding where on the graph
      # times should be rounded to. The "formatter" variable basically tells the method whether it should care
      # about the hour that the tweets were gathered from. And due to how levy's graph works, it only cares about hours
      # for 2 days or less. The rest of the method is used to assign tweets to specific plot points based on when they
      # were actually tweeted
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

    to_return = {}
    date_array = []
    value_array = []
    date_vals.each do |date, count|
      date_array<<date
      value_array<<count
      #to_return<<{"date"=> date, "value"=>count}
    end

    #Keys are string instead of symbols because it makes the transition to JSON easier
    to_return['dates'] = date_array
    to_return['values'] = value_array

    return total_count, to_return
  end

  def self.format_date_holder(from, now, formatter)
    date_vals={}
    from = Date.parse(from)
    now = Date.parse(now)

    if formatter == 1
      date_vals[from.to_s+" 00:00:00"] = 0
      date_vals[from.to_s+" 12:00:00"] = 0
      date_vals[from.to_s+" 18:00:00"] = 0
      date_vals[from.to_s+" 23:59:00"] = 0
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

  def self.get_searches(current_user)
    search_holder = []
    #Searches.where(user_id: id).find_each do |search_history|
    #t = Searches.create!(:search_term =>'overthinking', :from_date=>'2018-11-11',:to_date=>'2018-11-12',
    #                 :number_of_tweets=>4)

    puts "mooooooo"
    puts current_user.class
    current_user.search_user do |search_history|
      search_holder<<search_history
    end
    return search_holder
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
