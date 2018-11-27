OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '855026829195-cv83s6a8q73ti6qah0fvjdgv325bqh8o.apps.googleusercontent.com', 'rKQ1BYb397wLETtfSGdsLB3q'
end
# Todo: hide the keys, please.
