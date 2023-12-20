class AppointmentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :authenticate_financial_planner!, only: %i[update destroy regenerate_url]

  def new
    @time_slot = TimeSlot.pre_register_time_slot(params[:date].to_date, params[:start_time])
    unless @time_slot.is_available
      return redirect_to users_path, flash: { warning: '予約枠がなくなりました。' }
    end
  end

  def create
    slot = TimeSlot.find(params[:time_slot_id])
    ActiveRecord::Base.transaction do
      current_user.appointments.create!(financial_planner_id: slot.financial_planner_id,
                                  time_slot_id: slot.id)
      slot.update!(is_available: false)
    end
    redirect_to users_path, flash: { success: '仮予約が完了しました' }
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
    redirect_to users_path, flash: { warning: '仮予約に失敗しました' }
  end

  def update
    if appointment.nil? 
      return redirect_to financial_planners_url, flash: { warning: '予約が見つかりませんでした' }
    end
    appointment.update!(status: :confirmed)
    CreateMeetingJob.perform_later(appointment.id)
    redirect_to financial_planners_url, flash: { success: '予約を確定しました' }
  rescue ActiveRecord::RecordInvalid
    redirect_to financial_planners_url, flash: { warning: '予約の確定に失敗しました' }
  end

  def destroy
    if appointment.nil? 
      return redirect_to financial_planners_url, flash: { warning: '予約が見つかりませんでした' }
    end
    ActiveRecord::Base.transaction do
      appointment.time_slot.update!(is_available: true)
      appointment.destroy!
    end

    redirect_to financial_planners_url, flash: { success: '予約をキャンセルしました' }
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed
    redirect_to financial_planners_url, flash: { warning: '予約のキャンセルに失敗しました' }
  end

  def regenerate_url
    if appointment.nil? 
      return redirect_to financial_planners_url, flash: { warning: '予約が見つかりませんでした' }
    end
    CreateMeetingJob.perform_later(appointment.id)
    redirect_to financial_planners_url, flash: { success: 'URLを再生成します' }
  end

  private

  def appointment
    @appointment ||= current_financial_planner.appointments.find_by(id: params[:appointment_id])
  end
end
