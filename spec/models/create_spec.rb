require 'spec_helper'
require 'rails_helper'

describe User do
  describe 'adding a new User' do
    context 'Test user has been added' do
      it 'should reject username that matches testUser' do
        User.create_user!({:user_name => 'testuser',:password => 'password', :verify_password => 'password', :email => 'email'})

        expect(User.create_user!({:user_name => 'testuser',:password => 'password',
                                  :verify_password => 'password', :email => 'email'})).to eq([false, "Invalid Email!"])


      end

    end


    it 'should reject users with invalid credentials' do
      username = 'wr ong'
      password = ' '
      email = 'hotdog'
      verify = 'hotdog2'
      input = { :user_name => username, :password => password, :email => email, :verify_password => verify}
      ret = [false, "Invalid Username!"]
      expect(User.create_user!(input)).to eq(ret)
    end
  end


end
