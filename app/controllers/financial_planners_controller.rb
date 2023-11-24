class FinancialPlannersController < ApplicationController
  before_action :authenticate_financial_planner!

  def index
    puts Date.today
    @time_slots = TimeSlot.all.where("date >= ?", Date.today).where("date < ?", Date.today >> 3).order(date: :desc)
  end
end
