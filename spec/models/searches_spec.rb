require 'spec_helper'
require 'rails_helper'

describe Searches do

  it 'should post a tweet' do
    Searches.test_functionality
  end

  describe 'searching Twitter by keyword' do
    it 'should call Twitter with hashtag keywords in a time frame' do
      expect(Searches).to receive(:gather_tweets).with('Ruby', '2018-10-10', '2018-10-25')
      Searches.gather_tweets('Ruby', '2018-10-10', '2018-10-25')
    end
  end


end
