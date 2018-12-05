# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'search_user', 'searches_users'
end

# Initialize the Rails application.
Rails.application.initialize!
