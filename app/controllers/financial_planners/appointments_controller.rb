module FinancialPlanners
  class AppointmentsController < ApplicationController
    before_action :authenticate_financial_planner!
    before_action :appointment, only: %i[update destroy]

    def update
      @appointment.update!(status: :confirmed)
      redirect_to financial_planners_url, flash: { success: '予約を確定しました' }
    rescue ActiveRecord::RecordInvalid => e
      redirect_to financial_planners_url, flash: { warning: '予約の確定に失敗しました' }
    end

    def destroy
      @appointment.time_slot.update!(is_available: true)
      @appointment.destroy!
      redirect_to financial_planners_url, flash: { success: '予約をキャンセルしました' }
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed => e
      redirect_to financial_planners_url, flash: { warning: '予約のキャンセルに失敗しました' }
    end

    private

    def appointment
      @appointment ||= Appointment.find(params[:appointment_id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to financial_planners_url, flash: { warning: '予約が見つかりませんでした' }
    end
  end
end
