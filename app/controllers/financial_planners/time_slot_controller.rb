module FinancialPlanners
  class TimeSlotController < ApplicationController
    before_action :authenticate_financial_planner!

    def create
      date = params[:date]
      start_time = params[:start_time]
      time_slot = TimeSlot.new(date: date.to_date, financial_planner_id: current_financial_planner.id, start_time: start_time)
      time_slot.save!
      redirect_to financial_planners_path, flash: { success: "登録完了" }
    rescue ActiveRecord::RecordInvalid => e
      redirect_to financial_planners_path, flash: { warning: e.record.errors[:date][0] }
    end

    private

    def time_slot_params
      params.permit(:date, :start_time)
    end
  end
end
