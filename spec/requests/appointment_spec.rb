require 'rails_helper'

RSpec.describe AppointmentsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:financial_planner) { FactoryBot.create(:financial_planner) }

  describe 'GET #new' do
    context 'when user is authenticated' do
      before do
        sign_in user
        create(:time_slot, financial_planner:, date: Date.today + 1.day, start_time: '10:00')
      end

      it 'renders the new template' do
        get new_appointment_path(date: Date.today + 1.day, start_time: '10:00')
        expect(response).to render_template(:new)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login page' do
        get new_appointment_path(date: Date.today + 1.day, start_time: '10:00')
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    let!(:time_slot) { create(:time_slot, financial_planner:, date: Date.today + 1.day, start_time: '10:00') }

    context 'when user is authenticated' do
      before { sign_in user }

      it 'creates a new appointment and redirects' do
        expect do
          post appointments_path, params: { time_slot_id: time_slot.id }
        end.to change(Appointment, :count).by(1)
        expect(response).to redirect_to(users_path)
        expect(flash[:success]).to eq('仮予約が完了しました')
      end

      it 'does not create a new appointment if the time slot is not available' do
        expect do
          post appointments_path, params: { time_slot_id: nil }
        end.to change(Appointment, :count).by(0)
        expect(response).to redirect_to(users_path)
        expect(flash[:warning]).to eq('仮予約に失敗しました')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to login page' do
        get new_appointment_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:appointment) { create(:appointment) }

    context 'when financial planner is authenticated' do
      before { sign_in financial_planner }

      it 'updates the appointment and redirects' do
        patch appointment_path(appointment), params: { appointment_id: appointment.id }
        appointment.reload
        expect(appointment.status).to eq('confirmed')
        expect(response).to redirect_to(financial_planners_url)
        expect(flash[:success]).to eq('予約を確定しました')
      end

      it 'does not update the appointment if the appointment is not found' do
        patch appointment_path(0), params: { appointment_id: 0 }
        appointment.reload
        expect(appointment.status).to eq('pending')
        expect(response).to redirect_to(financial_planners_url)
        expect(flash[:warning]).to eq('予約が見つかりませんでした')
      end
    end

    context 'when financial planner is not authenticated' do
      it 'redirects to login page' do
        patch appointment_path(appointment.id)
        expect(response).to redirect_to(new_financial_planner_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:appointment) { create(:appointment) }

    context 'when financial planner is authenticated' do
      before { sign_in financial_planner }

      it 'destroys the appointment and redirects' do
        expect do
          delete appointment_path(appointment), params: { appointment_id: appointment.id }
        end.to change(Appointment, :count).by(-1)
        expect(response).to redirect_to(financial_planners_url)
        expect(flash[:success]).to eq('予約をキャンセルしました')
      end

      it 'does not destroy the appointment if the appointment is not found' do
        expect do
          delete appointment_path(0)
        end.to change(Appointment, :count).by(0), params: { appointment_id: 0 }
        expect(response).to redirect_to(financial_planners_url)
        expect(flash[:warning]).to eq('予約が見つかりませんでした')
      end
    end

    context 'when financial planner is not authenticated' do
      it 'redirects to login page' do
        delete appointment_path(appointment.id)
        expect(response).to redirect_to(new_financial_planner_session_path)
      end
    end
  end
end
