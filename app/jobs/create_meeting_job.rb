class CreateMeetingJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform(appointment_id)
    # Do something later
    appointment = Appointment.find(appointment_id)
    topic = appointment.financial_planner.name + 'さんとの面談'
    start_time = appointment.formatted_datetime
    app = Zooms::App.new(topic, start_time)
    meeting = app.create!
    appointment.update!(join_url: meeting["join_url"], start_url: meeting["start_url"])
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, StandardError=> e
    Rails.logger.error e.message
  end
end
