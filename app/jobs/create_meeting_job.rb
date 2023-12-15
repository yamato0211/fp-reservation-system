class CreateMeetingJob < ApplicationJob
  queue_as :default
  retry_on ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, StandardError, wait: 5.seconds, attempts: 3

  def perform(*args)
    # Do something later
    appointment = Appointment.find(args[0])
    topic = appointment.financial_planner.name + 'さんとの面談'
    date = appointment.time_slot.date.strftime('%Y-%m-%d')
    time = appointment.time_slot.start_time
    datetime_conbined = "#{date}T#{time}:00"
    formatted_datetime = DateTime.strptime(datetime_conbined, '%Y-%m-%dT%H:%M:%S')
    formatted_datetime_str = formatted_datetime.strftime('%Y-%m-%dT%H:%M:%S')
    app = Zooms::App.new(topic, formatted_datetime_str)
    meeting = app.create!
    appointment.update!(join_url: meeting["join_url"], start_url: meeting["start_url"])
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, StandardError=> e
    Rails.logger.error e.message
  end
end
