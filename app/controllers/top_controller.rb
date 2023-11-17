class TopController < ApplicationController
  before_action :authenticate_any

  def index
  end

  private
  def authenticate_any
    unless financial_planner_signed_in? || user_signed_in?
      redirect_to signup_index_url
    end
  end
end
