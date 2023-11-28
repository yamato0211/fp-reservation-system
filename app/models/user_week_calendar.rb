class SimpleCalendar::UserWeekCalendar < SimpleCalendar::Calendar
  # def to_partial_path
  #   'simple_calendar/user_week_calendar'
  # end

  private

  def date_range
    beginning = start_date.beginning_of_week + 1.day
    ending    = start_date.end_of_week - 1.day
    (beginning..ending).to_a
  end
end