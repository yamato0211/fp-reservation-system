class UsersController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def show
    @appointments = current_user.appointments.confirmed.order(created_at: :desc)
    @pre_appointments = current_user.appointments.pending.order(created_at: :desc)
  end
end
