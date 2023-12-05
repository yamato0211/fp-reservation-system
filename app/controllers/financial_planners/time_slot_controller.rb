module FinancialPlanners
  class TimeSlotController < ApplicationController
    before_action :authenticate_financial_planner!

    def create
      time_slot = TimeSlot.new(time_slot_params)
      if time_slot.save
        redirect_to financial_planners_path, flash: { success: "登録完了" }
      else
        redirect_to financial_planners_path, flash: { warning: "登録日付を確認してください" }
      end
    end

    private

    def time_slot_params
      params.require(:time_slot).permit(:date, :start_time, :financial_planner_id)
    end
  end
end
