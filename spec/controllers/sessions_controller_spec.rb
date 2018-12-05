require 'spec_helper'
require 'rails_helper'

describe SessionsController do
  describe 'logging in' do
    it 'should call the method that does the login verification' do
      fake_results = [double('user1')]
      expect(Session).to receive(:verify_login).with({:user_name => "hi"}).
        and_return(fake_results)
      post :create, :user => {:user_name => "hi"}
    end
    it 'should select the home page for rendering after successful login.' do
      fake_results = [double('new_user_session')]
      allow(Session).to receive(:verify_login).and_return(fake_results)

      post :create, :user => {:user_name => "hi"}
      #response.should redirect_to users_show_path
      expect(response).to redirect_to users_show_path
    end
    it 'should redirect back to the login page after incorrect login' do
      allow(Session).to receive(:verify_login).and_return(nil)
      post :create, :user => {:user_name => "hi"}
      expect(response).to redirect_to login_path
      #response.should redirect_to login_path
    end

  end
end
