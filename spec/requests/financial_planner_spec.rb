require 'rails_helper'

RSpec.describe 'FinancialPlanners', type: :request do
  let(:financial_planner) { FactoryBot.create(:financial_planner) }

  before do
    sign_in financial_planner
  end

  describe 'GET /financial_planners' do
    it 'renders the index template' do
      get financial_planners_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /financial_planners/:id' do
    it 'renders the show template' do
      get financial_planner_path(financial_planner)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end
