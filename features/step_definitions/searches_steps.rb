Given /^I am on the main page$/ do
  visit root_path
end

# Given /^The following searches have already been made:$/ do |searches_table|
#   searches_table.hashes.each do |search|
#     Searches.create!(search)
#   end
# end

When /^I make a search with search term "(.*?)", twitter handle "(.*?)", and time range "(.*?)"$/ do |search_term, handle, time|
  fill_in 'Keyword', :with => search_term
  fill_in 'Twitter Handle', :with => handle
  select time, :from => 'time'
  click_button 'Search'
end

When /^I make a search without a search term but with a handle "(.*?)" and time "(.*?)"$/ do |handle, time|
  fill_in 'Twitter Handle', :with => handle
  select time, :from => 'time'
  click_button 'Search'
end

Then /^The search page should flash notice the user$/ do
  error_message = page.find("#notice").text
  error_message.should == "please enter search term"
end

Then /^I should see the term searched "(.*?)" in the table$/ do |search_term|
  result = false
  all("td").each do |td|
    if td.has_content?(search_term.to_s)
      result = true
    end
  end
  expect(result).to be true
end

# Then /^I should see a search list with ids that match the user id "(.*?)"$/ do |id|
#   result=false
#   all("tr").each do |tr|
#     if tr.has_field?(user_id, :with => id)
#       result = true
#     else
#       result = false
#     end
#   end
#   expect(result).to be true
# end
