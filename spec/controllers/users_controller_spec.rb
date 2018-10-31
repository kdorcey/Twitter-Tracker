require 'spec_helper'
require 'rails_helper'

=begin
describe UsersController do
  describe 'creating a user' do
    it 'should redirect back to the signup page with incorrect sign up parameters' do
      test_user = {:user_name => 'Ted', :email => 'asldfjskldf', :password => 'asdf'}
      post :create, {:user => test_user, :verify_password => 'asdf'}
      expect(response).to render_template('login_create')
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
  end
=end
