require 'spec_helper'
require 'rails_helper'

describe Searches do

  it 'should post a tweet' do
    Searches.test_functionality
  end

  describe 'formatting date holder' do
    it 'should properly format the date_vals hash' do
      #expect(Searches).to receive(:gather_tweets).with('Ruby', '2018-10-10', '2018-10-25')
      ret = {"2018-10-12"=> 0, "2018-10-13"=>0, "2018-10-14"=>0}
      expect(Searches.format_date_holder("2018-10-12","2018-10-14",3)).
        to eq(ret)
    end
  end

  
end
