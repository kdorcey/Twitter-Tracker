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

When /^I choose to create a user with the username "(.*?)", email "(.*?)", password "(.*?)", verify password "(.*?)", and country "(.*?)"$/ do |user_name, email, password, verify_pass, country|
  fill_in 'User-ID', :with => user_name
  fill_in 'E-mail', :with => email
  fill_in 'Password', :with => password
  fill_in 'verify_password_', :with => verify_pass
  select country, :from => 'country'
  click_button 'Create my account'
end


Then /^The login page should welcome user "(.*?)"$/ do |user_name|
  welcome_message = page.find("#notice").text
  welcome_message.should == "New Account Created! Welcome, #{user_name} - Enjoy your stay. :D"
end

Then /^The same page should display a "(.*?)" error$/ do |error_string|
  error_notice = page.find("#notice").text
  error_notice.should == error_string
end

When /^I choose to login with the username "(.*?)" and the password "(.*?)"$/ do |username, password|
  fill_in 'User-ID', :with => username
  fill_in 'Password', :with => password
  click_button 'Login to my account'
end

Then /^My homepage should welcome me as "(.*?)"$/ do |username|
  welcome_message = page.find("#profile_link").text
  welcome_message.should == "#{username}'s Profile"
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
