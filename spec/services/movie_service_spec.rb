require 'rails_helper'

describe MovieService do
  describe '#top rated movies' do
    it 'displays data for top 40 rated movies' do
      VCR.use_cassette('top_rated_movies') do
        response_page_1 = MovieService.top_rated_movies(1)
        response_page_2 = MovieService.top_rated_movies(2)
        response = response_page_1 + response_page_2
        title = 'Dilwale Dulhania Le Jayenge'

        expect(response).to be_an(Array)
        expect(response.first).to be_a(Hash)
        expect(response.first[:title]).to eq(title)
        expect(response.first[:vote_average]).to eq(8.8)
        expect(response.count).to eq(40)
      end
    end
  end

  describe '#movie_search(query)' do
    it 'returns movies from search query' do
      VCR.use_cassette('movie_search') do
        query = 'Earth'
        response_page_1 = MovieService.movie_search(query, 1)
        response_page_2 = MovieService.movie_search(query, 2)
        response = response_page_1 + response_page_2
        title1 = '22 vs. Earth'
        title2 = "Daleks' Invasion Earth: 2150 A.D."

        expect(response).to be_an(Array)
        expect(response.count).to eq(40)
        expect(response.first).to be_a(Hash)
        expect(response.first[:title]).to eq(title1)
        expect(response.last[:title]).to eq(title2)
      end
    end
  end

  describe '#find_movie(movie_id)' do
    it 'returns movie from search query' do
      VCR.use_cassette('find_free_willy') do
        movie_id = 1634
        response = MovieService.find_movie(movie_id)
        title = 'Free Willy'
        id = 1634
        vote_average = 6.2
        runtime = 112

        expect(response).to be_a(Hash)
        expect(response.count).to eq(25)
        expect(response[:title]).to eq(title)
        expect(response[:vote_average]).to eq(vote_average)
        expect(response[:runtime]).to eq(runtime)
        expect(response[:genres]).to be_an(Array)
        expect(response[:genres].first).to be_a(Hash)
        expect(response[:genres].first[:name]).to eq("Family")
        expect(response[:genres][1][:name]).to eq("Adventure")
        expect(response[:genres].last[:name]).to eq("Drama")
        expect(response[:overview]).to be_a(String)
      end
    end
  end

  describe '#find_movie_cast(movie_id)' do
    it 'returns movie cast from search query' do
      VCR.use_cassette('find_jurassic_park_cast') do
        movie_id = 329
        response = MovieService.find_movie_cast(movie_id)
        title = 'Jurassic Park'
        name1 = 'Sam Neill'
        name2 = 'Samuel L. Jackson'

        expect(response[:cast]).to be_an(Array)
        expect(response[:cast].first).to be_a(Hash)
        expect(response[:cast].first[:name]).to eq(name1)
        expect(response[:cast][9][:name]).to eq(name2)
      end
    end
  end

  describe '#find_movie_reviews(movie_id)' do
    it 'returns movie reviews from search query' do
      VCR.use_cassette('find_jurassic_park_reviews') do
        movie_id = 329
        response = MovieService.find_movie_reviews(movie_id)
        username1 = 'BinaryCrunch'
        username2 = 'nsinger99'

        expect(response).to be_an(Array)
        expect(response.count).to eq(4)
        expect(response.first[:author_details][:username]).to eq(username1)
        expect(response.last[:author_details][:username]).to eq(username2)
        expect(response.first[:content]).to be_a(String)
        expect(response.last[:content]).to be_a(String)
      end
    end
  end
end
