class TimeSlot < ApplicationRecord
  belongs_to :financial_planner
  has_one :appointment

  validates :financial_planner_id, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :financial_planner_id, uniqueness: { scope: %i[date start_time] }
  validate :date_before_start
  validate :date_current_today
  validate :date_three_month_end

  def date_before_start
    errors.add(:date, "は過去の日付は選択できません") if date < Date.current
  end

  def date_current_today
    errors.add(:date, "は当日は選択できません。予約画面から正しい日付を選択してください。") if date < (Date.current + 1)
  end

  def date_three_month_end
    errors.add(:date, "は3ヶ月以降の日付は選択できません") if (Date.current >> 3) < date
  end

  def self.time_slots_after_three_month_with_fp(financial_planner_id)
    time_slots = TimeSlot.all.where("date >= ?", Date.today).where("date < ?", Date.today >> 3).where("financial_planner_id = ?", financial_planner_id).order(date: :desc)
    time_slots_data = []
    time_slots .each do |slot|
      time_slots_hash = {}
      time_slots_hash.merge!(date: slot.date.strftime("%Y-%m-%d"), start_time: slot.start_time, is_available: slot.is_available)
      time_slots_data.push(time_slots_hash)
    end
    time_slots_data
  end

  def self.time_slots_after_three_month
    time_slots = TimeSlot.all.where("date >= ?", Date.today).where("date < ?", Date.today >> 3).order(date: :desc)
    time_slots_data = []
    time_slots .each do |slot|
      time_slots_hash = {}
      time_slots_hash.merge!(date: slot.date.strftime("%Y-%m-%d"), start_time: slot.start_time, is_available: slot.is_available)
      time_slots_data.push(time_slots_hash)
    end
    time_slots_data
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
