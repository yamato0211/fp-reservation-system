class UsersController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def show
    @appointments = Appointment.get_appointments_with_user_id(current_user.id)
    @pre_appointments = Appointment.get_pre_appointments_with_user_id(current_user.id)
  end
end
