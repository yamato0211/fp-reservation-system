require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    subject do
      get users_path
      response
    end
    let(:user) { create(:user) }
    context 'ログイン済みアクセス' do
      before { sign_in user }
      it { is_expected.to have_http_status(:success) }
    end

    context '未ログインアクセス' do
      before { sign_out user }
      it { is_expected.to have_http_status(:redirect) }
    end
  end
end
