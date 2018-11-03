require 'spec_helper'
require 'rails_helper'

describe User do
  describe 'adding a new User' do
    context 'sad paths :(' do
      it 'should return error code false for usernames already in the database' do
        User.create!({:user_name => 'test',:email=>'test@gmail.com'})
        user = {:user_name => 'test', :email=> 'moo@gmail.com'}
        expect(User.create_user!(user)[0]).to eq(false)
      end
      it 'should return error code false for emails already in the database' do
        User.create!({:user_name => 'test',:email=>'moo@gmail.com'})
        user = {:user_name => 'different', :email=> 'moo@gmail.com'}
        expect(User.create_user!(user)[0]).to eq(false)
      end
      it 'should return error code false for invalid emails' do
        user = {:user_name => 'different', :email=> 'moo 2@gmail.com'}
        expect(User.create_user!(user)[0]).to eq(false)
      end
      it 'should return error code false for invalid usernames' do
        user = {:user_name => 'diffe rent', :email=> 'moo2@gmail.com'}
        expect(User.create_user!(user)[0]).to eq(false)
      end
    end
    context 'happy path :)' do
      it 'should create a new table entry for that user' do
        user = {:user_name => 'testy', :email=> 'moo@gmail.com'}
        User.create_user!(user)
      end
    end
  end
end
