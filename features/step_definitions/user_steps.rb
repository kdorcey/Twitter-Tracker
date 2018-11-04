Given /^I am on the login page$/ do

end


Given /^the following users have signed up for "The Emotions of Twitter":/ do |users_table|
  users_table.hashes.each do |user|
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # Entries can be directly to the database with ActiveRecord methods
    # Add the necessary Active Record call(s) to populate the database.
    user[:session_token] = SecureRandom.base64
    user[:password] = BCrypt::Password.create(user[:password])

    User.create!(user)
  end
end

When /^I choose to create a user with the username "(.*?)", email "(.*?)", password "(.*?)", and country "(.*?)"$/ do |user_name, email, password, country|

end


Then /^The login page should welcome user "(.*?)"$/ do |user_name|

end
