require 'rails_helper'

RSpec.describe FinancialPlanners::TimeSlotController, type: :controller do
  describe 'POST #create' do
    let(:financial_planner) { FactoryBot.create(:financial_planner) }

    context 'when the financial planner is authenticated' do
      before do
        sign_in financial_planner
      end

      context 'with valid parameters' do
        let(:valid_params) { { financial_planner_id: financial_planner.id, date: Date.today + 1.day, start_time: '10:00' } }

        it 'creates a new time slot' do
          expect do
            post :create, params: valid_params
          end.to change(TimeSlot, :count).by(1)
        end

        it 'redirects to the financial planners url with a success message' do
          post :create, params: valid_params
          expect(response).to redirect_to(financial_planners_url)
          expect(flash[:success]).to eq('登録完了')
        end
      end

      context 'with invalid parameters' do
        let(:invalid_params) { { financial_planner_id: financial_planner.id, date: nil, start_time: '10:00' } }

        it 'does not create a new time slot' do
          expect do
            post :create, params: invalid_params
          end.not_to change(TimeSlot, :count)
        end

        it 'redirects to the financial planners url with a warning message' do
          post :create, params: invalid_params
          expect(response).to redirect_to(financial_planners_url)
          expect(flash[:warning]).to be_present
        end
      end
    end

    context 'when the financial planner is not authenticated' do
      it 'redirects to the sign in page' do
        post :create, params: { financial_planner_id: financial_planner.id, date: Date.today + 1.day, start_time: '10:00' }
        expect(response).to redirect_to(new_financial_planner_session_url)
      end
    end
  end
end
