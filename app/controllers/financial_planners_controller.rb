class FinancialPlannersController < ApplicationController
  before_action :authenticate_financial_planner!

  def index; end
end
