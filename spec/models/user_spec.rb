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
  describe 'grabbing data for the users history' do
      it 'should return an empty array if there is no user associated' do
        results = User.get_history(25723)
        expect(results).to eq([[], []])
      end
      it 'should return an empty array if there are no searches associated with a user' do
        results = User.get_history(4)
        expect(results).to eq([[], []])
      end
  end
  describe 'getting user information' do
      it 'should return empty arrays if the user doesnt exist.' do
        friend_list, friend_list_id = User.get_user_friends_and_ids("Not a username")
        expect(friend_list). to eq([])
        expect(friend_list_id). to eq([])
      end
      it 'should return empty arrays if a user has no friends, like Kyle!' do
        friends_list, friends_list_id = User.get_user_friends_and_ids(User.find_by_user_name('test').user_name)
        expect(friends_list). to eq([])
        expect(friends_list_id). to eq([])
      end
      it 'should return an array object if the history search call corresponds to no user input' do
        final_hash , search_ids = User.get_history("not a user")
        expect(final_hash).to be_an_instance_of(Array)
        expect(search_ids).to be_an_instance_of(Array)
      end
      it 'should return an array object if the history search call corresponds to an actual user' do
        final_hash, search_ids = User.get_history(User.find_by_user_name('test').id)
        expect(final_hash).to be_an_instance_of(Array)
        expect(search_ids).to be_an_instance_of(Array)
      end
  end
  end
end
