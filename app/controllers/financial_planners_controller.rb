class FinancialPlannersController < ApplicationController
  before_action :authenticate_financial_planner!

  def index; end

  def show
    @pre_appointments = current_financial_planner.appointments.pending.order(created_at: :desc)
    @appointments = current_financial_planner.appointments.confirmed.order(created_at: :desc)
  end
end
