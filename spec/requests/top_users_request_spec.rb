require 'rails_helper'

RSpec.describe 'TopUsers requests', type: :request do
  describe 'Github API', :vcr do
    context 'when true' do
      let(:github) do
        VCR.use_cassette('github_user') { Github.new user: 'pry', repo: 'pry' }
      end

      before do
        VCR.use_cassette('github_repo') { github.repositories.contribs.first(3) }
        params = { github_url: 'https://github.com/pry/pry' }
        post '/search', params
      end

      it 'view name first contribution' do
        expect(response.body).to include('banister')
      end

      it 'view name second contribution' do
        expect(response.body).to include('kyrylo')
      end

      it 'view name third contribution' do
        expect(response.body).to include('ConradIrwin')
      end
    end
  end

  describe 'GET /download_pdf', :vcr do
    let(:github) do
      VCR.use_cassette('github_user') { Github.new user: 'pry', repo: 'pry' }
    end

    before do
      VCR.use_cassette('github_repo') { github.repositories.contribs.first(3) }
      params = { github_url: 'https://github.com/pry/pry' }
      post '/search', params
    end

    context 'when true' do
      before do
        params = { id: 1, login: github.login.to_s }
        get '/download_pdf', params
      end

      it 'Content-Type PDF' do
        expect(response.headers['Content-Type']).to include('application/pdf')
      end

      it 'Content-Disposition attachment' do
        expect(response.headers['Content-Disposition']).to include('attachment')
      end

      it 'Content-Disposition file name user_1_top.pdf' do
        expect(response.headers['Content-Disposition']).to include('user_1_top.pdf')
      end
    end
  end
end
