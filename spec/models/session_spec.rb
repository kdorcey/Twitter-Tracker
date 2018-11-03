require 'spec_helper'
require 'rails_helper'

describe Session do
  describe 'user login' do
    it 'should return nil when an incorrect password is input' do
      session_token = Session.verify_login({:user_name => 'markus2', :password => '12345678' })
      expect(session_token).to eq(nil)
    end
    it 'should return nil when an incorrect username is input' do
      session_token = Session.verify_login({:user_name => 'asdfkhlakshdglkhalksdhg', :password => '1234' })
      expect(session_token).to eq(nil)
    end
    #Todo:: I think this is more of an integration test as Session interacts with User.
   # it 'should return the users session token when the correct username and password is input. ' do
   #   expect(Session.verify_login({:user_name => 'test1', :password => 'test3'})).to eq('zILcPWpm0GKtXmvZ+PyLYw==')
   #   session_token = Session.verify_login({:user_name => 'test1', :password => 'test3'})
   #   expect(session_token).to eq('zILcPWpm0GKtXmvZ+PyLYw==')
   # end
    it 'should ignore when no input is given, as in a blank username or password.' do
      session_token = Session.verify_login(:incorrect_hash_names => 'nil')
      expect(session_token).to eq(nil)
    end
end
end
