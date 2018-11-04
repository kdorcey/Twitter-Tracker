require 'spec_helper'
require 'rails_helper'

describe SearchesController do
  describe 'searching a keyword' do
    it 'should call the model method that performs Twitter search' do
      fake_results = [double('searches1'), double('searches2')]
      expect(Searches).to receive(:gather_tweets).with('Ruby').
        and_return(fake_results)
      post :gather_tweets, {:search_term => 'Ruby'}
    end
    it 'should flash the Tweet Count Results' do
      allow(Searches).to receive(:gather_tweets)
      post :create, {:search_term => 'Ruby'}
      expect(flash[:notice]).to be_present
    end
  end
end
