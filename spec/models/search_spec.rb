require 'spec_helper'
require 'rails_helper'

describe Search do

  describe 'get_searches' do
    it 'should return an empty array for users with no search history' do
      fake_user = User.create!(id: 400, user_name: "moo", email: "moo", password: "moo")
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



end

  

