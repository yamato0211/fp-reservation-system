module FinancialPlanners
  class AppointmentsController < ApplicationController
    before_action :authenticate_financial_planner!

    def update
      appointment_id = params[:appointment_id]
      appointment = Appointment.find(appointment_id)
      appointment.update!(status: :confirmed)
      redirect_to financial_planners_url, flash: { success: '予約を確定しました' }
    rescue e
      redirect_to financial_planners_url, flash: { warning: '予約の確定に失敗しました' }
    end

    def destroy
      appointment_id = params[:appointment_id]
      appointment = Appointment.find(appointment_id)
      appointment.destroy!
      redirect_to financial_planners_url, flash: { success: '予約をキャンセルしました' }
    rescue e
      redirect_to financial_planners_url, flash: { warning: '予約のキャンセルに失敗しました' }
    end

    private

    def appointment_params
      params.require(:appointment).permit(:appointment_id)
    end
  end
end
