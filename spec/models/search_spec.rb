require 'spec_helper'
require 'rails_helper'

describe Search do

  describe 'get_searches' do
    it 'should return an empty array for users with no search history' do
      fake_user = User.create!(id: 3)
      expect(Search.get_searches(fake_user)).to eq([])
    end
    it 'should call the necessary methods to retrieve a users search' do
      fake_user = double("fake_user")
      test = User.reflect_on_association(:search)

      allow(fake_user).to receive(:exists?).and_return(true)
      allow(fake_user).to receive(:id).and_return(2)


      expect(test).to_not be_nil
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
      fake_status = double('fake_status')
      fake_res = instance_double('faketwe')
      fake_res2 = instance_double('faketwe2')
      fake_result = instance_double('faketweet')
      fake_result2 = instance_double('faketweet2')
      search_result = [fake_result, fake_result2]

      allow(fake_client).to receive(:status).and_return(fake_status)
      allow(fake_status).to receive(:truncated?).and_return(false)

      allow(fake_input).to receive(:to_str).and_return("blah")
      allow(fake_res).to receive(:created_at).and_return(fake_result)
      allow(fake_result).to receive(:created_at).and_return(fake_result)
      allow(fake_result).to receive(:in_time_zone).
        and_return("2018-10-13 22:44:18 EST")
      allow(fake_input).to receive(:handle).and_return("blah")
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
