module FinancialPlannersHelper
  def ap_times
    return [
      "10:00",
      "10:30",
      "11:00",
      "11:30",
      "13:00",
      "13:30",
      "14:00",
      "15:00",
      "15:30",
      "16:00",
      "16:30",
      "17:00",
      "17:30"
    ]
  end

  def exclude_times
    return [
      "10:00",
      "10:30",
      "15:30",
      "16:00",
      "16:30",
      "17:00",
      "17:30"
    ]
  end

  def check_reservation(time_slots, date, start_time)
    result = false
    time_slots_count = time_slots.count
    if time_slots_count > 1
      time_slots.each do |slot|
        result = slot[:date].eql?(date.strftime("%Y-%m-%d")) && slot[:start_time].eql?(start_time) && slot[:is_available].eql?(true)
        return result if result
      end
    elsif time_slots_count == 1
      result = time_slots[0][:date].eql?(date.strftime("%Y-%m-%d")) && time_slots[0][:start_time].eql?(start_time) && time_slots[0][:is_available].eql?(true)
      return result if result
    end
    return result
  end
end
