class Searches < ActiveRecord::Base

  def self.test_functionality
    client = Searches.authenticate
    puts "BBBBBBBBBBBBBBBBBBBBB"
    client.update("I'm tweeting with ABC!")
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
