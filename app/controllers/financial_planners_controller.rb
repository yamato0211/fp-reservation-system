class FinancialPlannersController < ApplicationController
  before_action :authenticate_financial_planner!

  def index; end

  def show
    @pre_appointments = Appointment.get_pre_appointments_with_financial_planner_id(current_financial_planner.id)
    @appointments = Appointment.get_appointments_with_financial_planner_id(current_financial_planner.id)
  end
end
