require 'spec_helper'
require 'rails_helper'

describe User do
  describe 'adding a new User' do
    context 'Test user has been added' do
      it 'should reject username that matches testUser' do
        User.create_user!({:user_name => 'testuser',:password => 'password', :verify_password => 'password', :email => 'email'})

        expect(User.create_user!({:user_name => 'testuser',:password => 'password',
                                  :verify_password => 'password', :email => 'email'})).to be(false)
      end
    end

    context 'Testing Formatting' do
      it 'should reject emails with invalid formatting' do
        email = 'hot dog22@gmail.com'
        expect(User.email_is_valid?(email)==false).to be(true)
      end
      it 'should approve emails with valid formatting' do
        email = 'hotdog22@gmail.com'
        expect(User.email_is_valid?(email)).to be(true)
      end
      it 'should reject usernames with invalid formatting' do
        user_name = 'mrMagoo2 2'
        expect(User.username_is_valid?(user_name)).to be(false)
      end
      it 'should accept usernames with valid formatting' do
        user_name = 'mrMag.oo22'
        expect(User.username_is_valid?(user_name)).to be(true)
      end
    end
  end


end
