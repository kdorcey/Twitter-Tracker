require 'spec_helper'
require 'rails_helper'

describe SessionsController do
  describe 'logging in' do
    it 'should call the model method that logs in the user' do
      fake_results = [double('user_1')]
      expect(Session).to receive(:verify_login).with({:user_name => 'markus2', :password => '1234'}).
        and_return(fake_results)

      user = {:user_name => 'markus2', :password => '1234' }

      post :create, {:user => user}
    end
    it 'should have the TMDB search results be available for its given view' do
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(assigns(:movies)).to eq(fake_results)
    end
    it 'should check for and recognize invalid search terms input by the user' do
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => '             '}

      response.should redirect_to('/movies')

      post :search_tmdb, {:search_terms => ''}
      response.should redirect_to('/movies')
    end
    it 'should redirect to the home page if no movies are found in the database' do
      post :search_tmdb, {:search_terms => 'a;slkgnja;slkgjas;lkgjaslk;gjasklgjaslkglka;shgl;kashg;lkashg;lkashgk;anglkawem glawiuvnawiuvnawelkjgnakjegnaliunbawlgnkljawnglkjawnglkjawebglkjawebglkwaejg'}
      response.should redirect_to('/movies')
    end

  end
  describe 'Adding Selected Movies to TMDB' do
    it 'should call the model method that finds movies from the TMDB database' do
      fake_results = [double('Movie')]
      expect(Movie).to receive(:create_from_tmdb).with('941').and_return(fake_results)
      post :add_tmdb, {:tmdb_movies => {'941' => 1}}
    end
    it 'should redirect to the home page after adding movies to the TMDB database' do
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:create_from_tmdb).and_return (fake_results)
      post :add_tmdb, {:tmdb_movies => {'941' => 1}}

      response.should redirect_to('/movies')
    end
  end
end
