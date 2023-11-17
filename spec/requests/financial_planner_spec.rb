require 'rails_helper'

RSpec.describe 'FinancialPlanners', type: :request do
  describe 'GET /financial_planners' do
    subject do
      get financial_planners_path
      response
    end
    let(:fp) { create(:financial_planner) }
    context 'ログイン済みアクセス' do
      before { sign_in fp }
      it { is_expected.to have_http_status(:success) }
    end

    context '未ログインアクセス' do
      before { sign_out fp }
      it { is_expected.to have_http_status(:redirect) }
    end
  end
end
