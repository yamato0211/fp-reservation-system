class TimeSlotsController < ApplicationController
  before_action :authenticate_financial_planner!

  def new
    @time_slot = TimeSlot.new
    @date = params[:date]
    @start_time = params[:start_time]
    message = TimeSlot.check_reservation_day(@date.to_date)
    if !!message
      redirect_to financial_planners_path, flash: { alert: message }
    end
  end

  def create
    @time_slot = TimeSlot.new(time_slot_params)
    if @time_slot.save
      redirect_to financial_planners_path
    else
      render :new
    end
  end

  def destroy_all
    date = params[:date]
    financial_planner_id = params[:financial_planner_id]
    message = TimeSlot.check_delete_day(date.to_date)
    if !!message
      redirect_to financial_planners_path, flash: { alert: message }
    else
      TimeSlot.where(date: date.to_date, financial_planner_id: financial_planner_id).destroy_all
      redirect_to financial_planners_path
    end
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:date, :start_time, :financial_planner_id)
  end
end
