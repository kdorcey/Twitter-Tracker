require 'spec_helper'
require 'rails_helper'

describe Search do

  describe 'get_searches' do
    it 'should return an empty array for users with no search history' do
      expect(Search.get_searches(3)).to eq([])
    end
    it 'should properly retrieve tweets associated to a user' do
      Search.create!(:user_id=>2, :search_term =>'overthinking', :from_date=>'2018-11-11', :to_date=>'2018-11-12',
                     :number_of_tweets=>4)
      Search.create!(:user_id=>2, :search_term =>'test', :from_date=>'2018-11-14', :to_date=>'2018-11-18',
                     :number_of_tweets=>23)

      expect(Search.get_searches(2)[0].search_term).to eq('overthinking')
      expect(Search.get_searches(2)[1].search_term).to eq('test')
    end
  end
  describe 'format_date_holder' do
    it 'should properly format date_vals for searches larger than 2 days' do
      ret = {"2018-10-12"=> 0, "2018-10-13"=>0, "2018-10-14"=>0}
      expect(Search.format_date_holder("2018-10-12", "2018-10-14", 3)).
        to eq(ret)
    end
    it 'should properly format date_vals for 2 day searches' do
      ret = {"2018-10-12 00:00:00"=>0, "2018-10-12 12:00:00"=>0,
             "2018-10-13 00:00:00"=>0, "2018-10-13 12:00:00"=>0}
      expect(Search.format_date_holder("2018-10-12", "2018-10-13", 2)).
        to eq(ret)
    end
    it 'should properly format date_vals for 1 day searches' do
      ret = {"2018-10-12 00:00:00"=>0, "2018-10-12 12:00:00"=>0,
             "2018-10-12 18:00:00"=>0, "2018-10-12 23:59:00"=>0}
      expect(Search.format_date_holder("2018-10-12", "2018-10-12", 1)).
        to eq(ret)
    end
  end

  describe 'gather_tweets' do
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


      expect(Search).to receive(:authenticate).and_return(fake_client)
      expect(Search).to receive(:format_date_holder).and_return(date_val)

      expect(fake_client).to receive(:search).and_return(search_result)
      expect(Search.gather_tweets(fake_input, fake_input, fake_input, fake_input, fake_input)).to eq([2, ret])
    end

  end

  
end