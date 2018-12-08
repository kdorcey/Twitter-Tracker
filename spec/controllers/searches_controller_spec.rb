require 'spec_helper'
require 'rails_helper'

describe SearchesController do
  describe 'Search Controller' do
    context 'making search' do
      # it 'should redirect to searches_display_path' do
      #   search = Search.new
      #   search.instance_variable_set(:@current_user, 'asdf')
      #   test_term = 'Test'
      #   test_user = 'evanmeyer07'
      #   test_from = '2018-01-01'
      #   test_to = '2018-01-01'
      #   post :create, {:searches => {:search_term => test_term, :search_user => test_user, :search_from => test_from, :search_to => test_to}}
      #   expect(response).to redirect_to searches_display_path
      # end
      it 'should redirect to root_path' do
        search = Search.new
        search.instance_variable_set(:@current_user, nil)
        test_term = 'Test'
        test_user = 'evanmeyer07'
        test_from = '2018-01-01'
        test_to = '2018-01-01'
        @current_user = nil
        post :create, {:searches => {:search_term => test_term, :search_user => test_user, :search_from => test_from, :search_to => test_to}}
        expect(response).to redirect_to root_path
      end
    end
    context 'saving search' do
      # it 'should redirect to root_path' do
      #   test_user = {:user_name => 'test', :email => 'testing@gmail.com', :password => 'password'}
      #   @current_user = test_user
      #   post :save_topic
      #   expect(response).to redirect_to root_path
      # end
      it 'should redirect to searches_path' do
        search = Search.new
        search.instance_variable_set(:@current_user, nil)
        test_term = 'Test'
        test_user = 'evanmeyer07'
        test_from = '2018-01-01'
        test_to = '2018-01-01'
        post :save_topic, {:searches => {:search_term => test_term, :search_user => test_user, :search_from => test_from, :search_to => test_to}}
        expect(response).to redirect_to searches_path
      end
    end
  end
end
