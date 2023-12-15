require 'rails_helper'

RSpec.describe FinancialPlanners::TimeSlotsController, type: :controller do
  let(:financial_planner) { create(:financial_planner) }
  let(:different_financial_planner) { create(:financial_planner) }

  before do
    sign_in financial_planner
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates new time slots" do
        expect {
          post :create, params: { financial_planner_id: financial_planner.id, date: Date.today + 1.day }
        }.to change(TimeSlot, :count).by(TimeSlot::SLOT_TIMES.count)
        expect(response).to redirect_to(financial_planners_url)
        expect(flash[:success]).to eq('登録完了')
      end
    end

    context "with invalid parameters" do
      it "does not create time slots" do
        expect {
          post :create, params: { financial_planner_id: financial_planner.id, date: Date.today }
        }.to_not change(TimeSlot, :count)

        expect(response).to redirect_to(financial_planners_url)
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe "DELETE /destroy" do
    context "when the financial planner is the owner of the time slots" do
      before do
        TimeSlot::SLOT_TIMES.each do |time|
          create(:time_slot, financial_planner: financial_planner, date: Date.today + 1.day, start_time: time)
        end
      end
      it "destroys the requested time slot" do
        expect {
          delete :destroy, params: { financial_planner_id: financial_planner.id, date: Date.today + 1.day }
        }.to change(TimeSlot, :count).by(-TimeSlot::SLOT_TIMES.count)
        expect(response).to redirect_to(financial_planners_url)
        expect(flash[:success]).to eq('削除完了')
      end
    end

    context "when the financial planner is not the owner of the time slots" do
      before do
        TimeSlot::SLOT_TIMES.each do |time|
          create(:time_slot, financial_planner: financial_planner, date: Date.today + 1.day, start_time: time)
        end
        
        sign_out financial_planner
        sign_in different_financial_planner
      end
      it "destroys the requested time slot" do
        expect {
          delete :destroy, params: { financial_planner_id: different_financial_planner.id, date: Date.today + 1.day }
        }.to change(TimeSlot, :count).by(0)
        expect(response).to redirect_to(financial_planners_url)
        expect(flash[:success]).to eq('削除完了')
      end
    end
  end
end
