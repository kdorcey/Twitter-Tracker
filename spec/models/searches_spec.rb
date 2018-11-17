require 'spec_helper'
require 'rails_helper'

describe Searches do

  it 'should post a tweet' do
    Searches.test_functionality
  end

  describe 'formatting date holder' do
    it 'should properly format date_vals for searches larger than 2 days' do
      ret = {"2018-10-12"=> 0, "2018-10-13"=>0, "2018-10-14"=>0}
      expect(Searches.format_date_holder("2018-10-12","2018-10-14",3)).
        to eq(ret)
    end
    it 'should properly format date_vals for 2 day searches' do
      ret = {"2018-10-12 00:00:00"=>0, "2018-10-12 12:00:00"=>0,
             "2018-10-13 00:00:00"=>0, "2018-10-13 12:00:00"=>0}
      expect(Searches.format_date_holder("2018-10-12","2018-10-13",2)).
        to eq(ret)
    end
    it 'should properly format date_vals for 1 day searches' do
      ret = {"2018-10-12 00:00:00"=>0, "2018-10-12 12:00:00"=>0,
             "2018-10-12 18:00:00"=>0, "2018-10-12 23:59:00"=>0}
      expect(Searches.format_date_holder("2018-10-12","2018-10-12",1)).
        to eq(ret)
    end
  end

  describe 'Searching tweets' do
    it 'should return a properly formatted json string' do
      date_val = {"2018-10-12"=> 0, "2018-10-13"=>0, "2018-10-14"=>0}
      ret = [{"date" =>"2018-10-12", "value" => 0},{"date" =>"2018-10-13", "value" => 2},
             {"date" =>"2018-10-14", "value" => 0}]
      fake_client = instance_double('fakeClinet')
      fake_input = double('fakeinput')
      fake_res = instance_double('faketwe')
      fake_res2 = instance_double('faketwe2')
      fake_result = instance_double('faketweet')
      fake_result2 = instance_double('faketweet2')
      search_result = [fake_result, fake_result2]


      allow(fake_input).to receive(:to_str).and_return("blah")
      allow(fake_res).to receive(:created_at).and_return(fake_result)
      allow(fake_result).to receive(:created_at).and_return(fake_result)
      allow(fake_result).to receive(:in_time_zone).
        and_return("2018-10-13 22:44:18 EST")
      allow(fake_res2).to receive(:created_at).and_return(fake_result2)
      allow(fake_result2).to receive(:created_at).and_return(fake_result2)
      allow(fake_result2).to receive(:in_time_zone).
        and_return("2018-10-13 10:50:18 EST")

      #expect(:format_date_holder).to receive(fake_input). with('2018-10-12', '2018-10-14',3).
      #  and_return(date_val)
      expect(Searches).to receive(:authenticate).and_return(fake_client)
      expect(Searches).to receive(:format_date_holder).and_return(date_val)
      #expect(client.search).to receive(:search_user, :query, :from). with('ArianaGrande', 'thank u', '2018-10-12').
      #  and_return(search_result)
      expect(fake_client).to receive(:search).and_return(search_result)
      expect(Searches.gather_tweets(fake_input, fake_input, fake_input, fake_input, fake_input)).to eq([2,ret])


    end

  end

  
end
