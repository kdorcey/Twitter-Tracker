# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


### USER SEEDS
#
users = [
  {:user_name => 'Kyle', :email => 'kylekyle@gmail.com', :password => 'lmaopasswordsaredumb', :country => 'United States', :search_inputs => []},
]

users.each do |user|
  User.create!(user)
end

# searches = [
#   {:user_id => User.find_by_sql('1'), :search_term => 'Kanye', :from_date => '2018-11-01', :to_date => '2018-11-02', :number_of_tweets => '100'}
# ]
#
# searches.each do |search|
#   Searches.create!(search)
# end
