require 'rails_helper'

RSpec.describe TopUsersController, type: :controller do
  render_views

  describe 'GET #index' do
    before do
      get :index, formats: 'json'
    end

    it 'get index and view text' do
      expect(response.body).to include('github top contributions')
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
