require 'rails_helper'

RSpec.describe TopUsersController, type: :controller do
  render_views

  describe 'GET #index' do
    before do
      get :index, formats: 'json'
    end

    it 'get index and view text' do
      expect(response.body).to match('github top contributions')
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #find_github_contributions' do
    context 'when true' do
      it 'browser set en locale' do
        # request.env['HTTP_ACCEPT_LANGUAGE'] = 'en-EN'
        # get :new, formats: 'json'
        # expect(response.body).to include('Flashcards')
      end
    end
  end
end
