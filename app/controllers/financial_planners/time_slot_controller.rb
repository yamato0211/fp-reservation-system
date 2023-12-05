module FinancialPlanners
  class TimeSlotController < ApplicationController
    before_action :authenticate_financial_planner!

    def create
      time_slot = TimeSlot.new(time_slot_params)
      time_slot.save!
      redirect_to financial_planners_path, flash: { success: "登録完了" }
    rescue ActiveRecord::RecordInvalid => e
      redirect_to financial_planners_path, flash: { warning: e.record.errors[:date][0] }
    end

    private

    def time_slot_params
      params.permit(:date, :start_time, :financial_planner_id)
    end
  end
end
