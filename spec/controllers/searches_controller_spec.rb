require 'spec_helper'
require 'rails_helper'

describe SearchesController do
  describe 'Search Controller' do
    context 'searching user' do
      it 'should find the current users current search' do
      end
    end

    context 'searching a term' do
      #describe 'searching a keyword' do

      #before(:each) do
      #allow_any_instance_of(SearchesController).to receive(:current_user).and_return(user)
      #end

      #before(:each) do
      #  allow(SearchesController).to receive(@current_user).and_return(user)
      #end

      #it 'should call the model method that performs Twitter search' do
      # fake_results = [double('searches1'), double('searches2'), double('searches3'), double('searches4'),
      #                 double('searches5'), double('searches6')]
      # test_search = {:search_term => 'Ruby', :search_user => 'Test'}
      # expect(Searches).to receive(:gather_tweets).with('Ruby', 'Test', (Date.today - 2).to_s, Date.today.to_s, 2).
      #  and_return(fake_results)
      #post :create, {:searches => test_search, :time => '2'}
      #end
      #it 'should select the Search Results template for rendering' do
      #test_search = {:search_term => 'Ruby', :search_user => 'Test'}
      #fake_user = double('user')
      #allow(SearchesController).to receive(@current_user).and_return(:current_user)
      #post :create, {:searches => test_search, :time => '3'}
      #response.should redirect_to searches_display_path
      #end
      #it 'should make the amount of Twitter search results available to that template' do
      # fake_results = [double('searches1'), double('searches2'), double('searches3'), double('searches4'),
      #                double('searches5'), double('searches6')]
      #test_search = {:search_term => 'Ruby', :search_user => 'Test'}
      #allow(Searches).to receive(:gather_tweets).and_return (fake_results)
      #post :create, {:searches => test_search, :time => '2'}
      #expect(assigns(:graph_data)).to eq(fake_results)
      #end
      #end
    end
  end
end
