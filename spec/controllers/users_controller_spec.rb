require 'spec_helper'
require 'rails_helper'

describe UsersController do
  describe 'creating a user' do
    context 'sad paths :(' do
    it 'should redirect back to the signup page with un-matching passwords' do
      test_user = {:user_name => 'Ted', :email => 'asldfjskldf', :password => 'unmatching_password'}
      verify_pass = ['doesnt_match']
      post :create, {:user => test_user, :verify_password => verify_pass}
      expect(response).to redirect_to new_user_path
    end
    it 'should redirect back to the signup page regardless of the type of input' do
      test_user = {:user_name => '', :email => 'test@gmail.com', :password => 'match'}
      verify_pass = ['match']
      post :create, {:user => test_user, :verify_password => verify_pass}
      expect(response).to redirect_to new_user_path
    end
    end
    context 'happy path! :D' do
    it 'should redirect to user login after correct inputs are input.' do
      test_user = {:user_name => 'testing', :email => 'testing@gmail.com', :password => 'password'}
      verify_pass = ['password']
      post :create, {:user => test_user, :verify_password => verify_pass}
      expect(response).to redirect_to login_path
    end
    end
  end
  describe 'grabbing users history' do
    #https://stackoverflow.com/questions/13008922/testing-response-cookie-with-rspec-v-1
    # Testing for this should be done in capybara and jasmin
    # results are user-dependant (on the person that is logged on).
  end
end
