require 'rails_helper'

RSpec.describe 'TopUsers', type: :request do
  before do
    stub_request(:get, 'https://api.github.com/repos/pry/pry/contributors')
      .with(
        headers: {
          'Accept' => 'application/vnd.github.v3+json,application/vnd.github.beta+json;q=0.5,application/json;q=0.1',
          'Accept-Charset' => 'utf-8',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Github API Ruby Gem 0.18.2'
        }
      )
      .to_return(status: 200, body: '', headers: {})
  end

  it 'creates a page' do
    params = { github_url: 'https://github.com/pry/pry' }
    post '/search', params

    # binding.pry
    # expect(response).to render(:index)
    # follow_redirect!

    # expect(response).to render_template(:show)
    # expect(response.body).to include('Widget was successfully created.')
  end
end
