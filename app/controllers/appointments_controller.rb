class AppointmentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :authenticate_financial_planner!, only: %i[update destroy]
  before_action :set_appointment, only: %i[update destroy]

  def new
    date = params[:date]
    start_time = params[:start_time]
    slot = TimeSlot.pre_register_time_slot(date.to_date, start_time)
    if TimeSlot.is_available_slot?(slot.id)
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
    ActiveRecord::Base.transaction do
      appointment.save!
      slot.update!(is_available: false)
    end
    redirect_to users_path, flash: { success: '仮予約が完了しました' }
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
    redirect_to users_path, flash: { warning: '仮予約に失敗しました' }
  end

  def update
    @appointment.update!(status: :confirmed)
    redirect_to financial_planners_url, flash: { success: '予約を確定しました' }
  rescue ActiveRecord::RecordInvalid
    redirect_to financial_planners_url, flash: { warning: '予約の確定に失敗しました' }
  end

  def destroy
    ActiveRecord::Base.transaction do
      @appointment.time_slot.update!(is_available: true)
      @appointment.destroy!
    end

    redirect_to financial_planners_url, flash: { success: '予約をキャンセルしました' }
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed
    redirect_to financial_planners_url, flash: { warning: '予約のキャンセルに失敗しました' }
  end

  private

  def set_appointment
    @appointment ||= Appointment.find(params[:appointment_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to financial_planners_url, flash: { warning: '予約が見つかりませんでした' }
  end
end
