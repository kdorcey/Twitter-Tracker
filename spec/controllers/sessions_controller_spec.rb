require 'spec_helper'
require 'rails_helper'

describe SessionsController do
  describe 'logging in' do
    it 'should check for and recognize invalid search terms input by the user' do
      fake_results = [double('new_user_session')]
      allow(Session).to receive(:verify_login).and_return(fake_results)

      post :create, {:search_terms => '             '}
      response.should redirect_to('/movies')

      post :search_tmdb, {:search_terms => ''}
      response.should redirect_to('/movies')
    end
    it 'should redirect to the home page if no movies are found in the database' do
      post :search_tmdb, {:search_terms => 'nbawlgnkljawnglkjawnglkjawebglkjawebglkwaejg'}
      response.should redirect_to('/movies')
    end
  end
end
