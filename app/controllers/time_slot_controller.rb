class TimeSlotController < ApplicationController
  before_action :authenticate_financial_planner!

  def create
    date = params[:date]
    start_time = params[:start_time]
    financial_planner_id = params[:financial_planner_id]
    time_slot = TimeSlot.new(date: date, start_time: start_time, financial_planner_id: financial_planner_id)
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
