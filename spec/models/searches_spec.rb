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

  
end
