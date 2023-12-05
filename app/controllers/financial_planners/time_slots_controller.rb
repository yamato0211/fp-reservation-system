module FinancialPlanners
  class TimeSlotsController < ApplicationController
    before_action :authenticate_financial_planner!

    def destroy
      date = params[:date]
      financial_planner_id = params[:financial_planner_id]
      message = TimeSlot.check_delete_day(date.to_date)
      if !!message
        redirect_to financial_planners_path, flash: { warning: message }
      else
        TimeSlot.where(date: date.to_date, financial_planner_id: financial_planner_id).destroy_all
        redirect_to financial_planners_path, flash: { success: "削除完了" }
      end
    end

    def create
      date = params[:date]
      financial_planner_id = params[:financial_planner_id]

      time_slot = TimeSlot.new(date: date, financial_planner_id: financial_planner_id)
      if time_slot.valid?
        times = TimeSlot.available_time_with_date(date, financial_planner_id)
        available_times = date.wday == 6 ? TimeSlot::SATURDAY_TIMES - times : TimeSlot::SLOT_TIMES - times
    
        time_slots_to_insert = available_times.map do |time|
          TimeSlot.new(date: date, financial_planner_id: financial_planner_id, start_time: time)
        end
    
        TimeSlot.import time_slots_to_insert
        redirect_to financial_planners_path, flash: { success: "登録完了" }
      else
        error_message = time_slot.errors.full_messages.join(", ")
        redirect_to financial_planners_path, flash: { warning: error_message }
      end
    end

    private

    def time_slot_params
      params.require(:time_slot).permit(:date, :start_time, :financial_planner_id)
    end
  end
end
