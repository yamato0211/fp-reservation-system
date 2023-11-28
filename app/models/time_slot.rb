class CreateTimeSlotValidator < ActiveModel::Validator
  def validate(record)
    if record.date.before?(Date.current)
      record.errors.add :date, "過去の日付は選択できません。正しい日付を選択してください。"
    end
    if record.date.before?(Date.current + 1)
      record.errors.add :date, "当日は選択できません。正しい日付を選択してください。"
    end
    if record.date.after?(Date.current + 3.months)
      record.errors.add :date, "は3ヶ月以降の日付は選択できません。"
    end
  end
end

class DeleteTimeSlotValidator < ActiveModel::Validator
  def validate(record)
    if record.date.before?(Date.current)
      record.errors.add :date, "過去の日付は選択できません。正しい日付を選択してください。"
    end
    if record.date.before?(Date.current + 1)
      record.errors.add :date, "当日の予定は削除できません。"
    end
    if record.date.after?(Date.current + 3.months)
      record.errors.add :date, "は3ヶ月以降の日付は選択できません。"
    end
  end
end

class TimeSlot < ApplicationRecord
  belongs_to :financial_planner
  has_one :appointment

  validates :financial_planner_id, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :financial_planner_id, uniqueness: { scope: %i[date start_time] }

  # validates with
  validates_with CreateTimeSlotValidator
  validates_with DeleteTimeSlotValidator

  # const
  SLOT_TIMES = [
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30"
  ]

  SATURDAY_TIMES = [
    "11:00",
    "11:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00"
  ]

  EXCLUDE_TIMES = [
    "10:00",
    "10:30",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30"
  ]

  def self.time_slots_after_three_month(financial_planner_id)
    time_slots = TimeSlot.all.where("date >= ?", Date.today).where("date < ?", Date.today + 3.months).where("financial_planner_id = ?", financial_planner_id).where("is_available = ?", true).order(date: :desc)
    time_slots_hash = {}
    time_slots.each do |slot|
      key = [slot.date.strftime("%Y-%m-%d"), slot.start_time].join("_")
      time_slots_hash[key] = {date: slot.date.strftime("%Y-%m-%d"), start_time: slot.start_time}
    end
    time_slots_hash
  end

  def self.time_slot_available?(time_slots, date, start_time)
    key = [date, start_time].join("_")
    time_slots.key?(key)
  end

  def self.available_time_with_date(date, financial_planner_id)
    time_slots = TimeSlot.all.where(date: date, financial_planner_id: financial_planner_id)
    slot_times = []
    time_slots.each do |slot|
      slot_times.push(slot.start_time)
    end
    slot_times
  end

  def self.check_reservation_day(day)
    if day < Date.current
      return "過去の日付は選択できません。正しい日付を選択してください。"
    elsif day < (Date.current + 1)
      return "当日は選択できません。正しい日付を選択してください。"
    elsif (Date.current >> 3) < day
      return "3ヶ月以降の日付は選択できません。正しい日付を選択してください。"
    end
  end

  def self.check_delete_day(day)
    if day < Date.current
      return "過去の日付は選択できません。正しい日付を選択してください。"
    elsif day < (Date.current + 1)
      return "当日の予定は削除できません。"
    elsif (Date.current >> 3) < day
      return "3ヶ月以降の日付は選択できません。正しい日付を選択してください。"
    end
  end
end
