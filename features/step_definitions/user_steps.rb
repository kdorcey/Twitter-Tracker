Given /^I am on the login page$/ do
  visit login_path
end

Given /^I am on the signup page$/ do
  visit new_user_path
end


Given /^the following users have signed up for "The Emotions of Twitter":/ do |users_table|
  users_table.hashes.each do |user|

    user[:session_token] = SecureRandom.base64
    user[:password] = BCrypt::Password.create(user[:password])

    User.create!(user)
  end
end

When /^I choose to create a user with the username "(.*?)", email "(.*?)", password "(.*?)", and country "(.*?)"$/ do |user_name, email, password, country|
  fill_in 'User-ID', :with => user_name
  fill_in 'E-mail', :with => email
  fill_in 'Password', :with => password
  fill_in 'verify_password_', :with => password
  select country, :from => 'country'
  click_button 'Create my account'
end


Then /^The login page should welcome user "(.*?)"$/ do |user_name|
  welcome_message = page.find("#notice").text
  welcome_message.should == "New Account Created! Welcome, #{user_name} - Enjoy your stay. :D"
end

When /^I have search a term "(.*?)" in the "(.*?)"$/ do |title, time|
  visit searches_path
  fill_in 'Keyword', :with => title
  select time, :from => 'Time'
  click_button 'Search'
end

Then /^I should see a search list entry with title "(.*?)" and the number of times tweeted in a time frame$/ do |title|
  result=false
  all("tr").each do |tr|
    if tr.has_content?(title)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end
