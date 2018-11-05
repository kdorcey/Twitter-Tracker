require 'spec_helper'
require 'rails_helper'

describe SearchesController do
  describe 'searching a keyword' do
    it 'should call the model method that performs Twitter search' do
      fake_results = double('Integer')
      expect(Searches).to receive(:gather_tweets).with('Ruby', :time => '2').
        and_return(fake_results)
      post :gather_tweets, {:search_term => 'Ruby', :time => '2'}
    end
    it 'should select the Search Results template for rendering' do
      allow(Searches).to receive(:gather_tweets)
      post :create, {:search_term => 'Ruby', :time => '2'}
      response.should redirect_to searches_path
    end
    it 'should make the amount of Twitter search results available to that template' do
      fake_results = double('Integer')
      allow(Searches).to receive(:gather_tweets).and_return (fake_results)
      post :create, {:search_term => 'Ruby', :time => '2'}
      expect(assigns(:count)).to eq(fake_results)
    end
  end
end
