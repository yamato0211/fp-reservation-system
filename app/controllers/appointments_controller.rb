class AppointmentsController < ApplicationController
  def new
  end

  def create
    date = params[:date]
    start_time = params[:start_time]
    user_id = params[:user_id]
    slot = TimeSlot.pre_register_time_slot(date.to_date, start_time)
    appointment = Appointment.new(user_id: user_id, financial_planner_id: slot.financial_planner_id, time_slot_id: slot.id)
    if appointment.save
      redirect_to financial_planners_path, flash: { success: "仮予約が完了しました" }
    else
      redirect_to financial_planners_path, flash: { warning: "仮予約に失敗しました" }
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :start_time, :user_id)
  end
end
