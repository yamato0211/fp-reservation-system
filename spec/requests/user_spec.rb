require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'GET /users' do
    it 'renders the index template' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:id' do
    it 'renders the show template' do
      get user_path(user)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end
