module SimpleCalendar
  class UserWeekCalendar < SimpleCalendar::WeekCalendar
    def to_partial_path
      'simple_calendar/user_week_calendar'
    end
  
    def date_range
      beginning = start_date.beginning_of_week
      ending    = start_date.end_of_week
      (beginning..ending).to_a
    end
  end
end

