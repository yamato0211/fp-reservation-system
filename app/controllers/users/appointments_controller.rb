module Users
  class AppointmentsController < ApplicationController
    before_action :authenticate_user!
    def new
      date = params[:date]
      start_time = params[:start_time]
      slot = TimeSlot.pre_register_time_slot(date.to_date, start_time)
      if TimeSlot.is_available_slot?(slot.id)
        @appointment = Appointment.new
        @financial_planner = FinancialPlanner.find(slot.financial_planner_id)
        @date_time = [slot.date.strftime('%Y-%m-%d'), slot.start_time].join(' ')
        @time_slot_id = slot.id
      else
        redirect_to users_path, flash: { warning: '予約枠がなくなりました。' }
      end
    end

    def create
      time_slot_id = params[:time_slot_id]
      user_id = current_user.id
      slot = TimeSlot.find(time_slot_id)
      appointment = Appointment.new(user_id:, financial_planner_id: slot.financial_planner_id,
                                    time_slot_id: slot.id)
      appointment.save!
      slot.update!(is_available: false)
      redirect_to users_path, flash: { success: '仮予約が完了しました' }
    rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid => e
      redirect_to users_path, flash: { warning: '仮予約に失敗しました' }
    end
  end
end
