class TimeSlot < ApplicationRecord
  belongs_to :financial_planner
  has_one :appointment

  validates :financial_planner_id, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :financial_planner_id, uniqueness: { scope: %i[date start_time] }

  # validates with
  validates_with TimeSlots::CreateTimeSlotValidator, on: :create
  validates_with TimeSlots::DeleteTimeSlotValidator, on: :destroy

  # const
  SLOT_TIMES = %w[10:00 10:30 11:00 11:30 12:00 12:30 13:00 13:30 14:00 14:30 15:00 15:30 16:00 16:30 17:00 17:30]

  SATURDAY_TIMES = %w[11:00 11:30 12:00 12:30 13:00 13:30 14:00 14:30 15:00]

  EXCLUDE_TIMES = %w[10:00 10:30 15:30 16:00 16:30 17:00 17:30]

  # scope
  scope :collect_date, -> { where('date >= ?', Date.today).where('date < ?', Date.today + 3.months) }
  scope :is_available, -> { where(is_available: true) }
  scope :desc, -> { order(date: :desc) }

  def join_date_start_time
    [date.strftime('%Y-%m-%d'), start_time].join(' ')
  end

  class << self
    def time_slots_after_three_month(financial_planner_id)
      time_slots = TimeSlot.all.collect_date.where(financial_planner_id:).desc
      time_slots_hash = {}
      time_slots.each do |slot|
        key = [slot.date.strftime('%Y-%m-%d'), slot.start_time].join('_')
        time_slots_hash[key] = { date: slot.date.strftime('%Y-%m-%d'), start_time: slot.start_time }
      end
      time_slots_hash
    end

    def time_slot_available?(time_slots, date, start_time)
      key = [date, start_time].join('_')
      time_slots.key?(key)
    end

    def available_time_with_date(date, financial_planner_id)
      time_slots = TimeSlot.all.where(date:, financial_planner_id:)
      slot_times = []
      time_slots.each do |slot|
        slot_times.push(slot.start_time)
      end
      slot_times
    end

    def available_appointment_time_slots
      time_slots = TimeSlot.select('DISTINCT date, start_time').collect_date.is_available.desc
      time_slots_hash = {}
      time_slots.map do |slot|
        key = [slot.date.strftime('%Y-%m-%d'), slot.start_time].join('_')
        time_slots_hash[key] = { date: slot.date.strftime('%Y-%m-%d'), start_time: slot.start_time }
      end
      time_slots_hash
    end

    def appointment_time_slot_available?(time_slots, date, start_time)
      key = [date, start_time].join('_')
      if date.saturday?
        return SATURDAY_TIMES.include?(start_time) && time_slots.key?(key)
      elsif date.sunday?
        return false
      else
        return SLOT_TIMES.include?(start_time) && time_slots.key?(key)
      end
    end

    def pre_register_time_slot(date, start_time)
      time_slots = TimeSlot.all.where(date:, start_time:, is_available: true)
      rand_num = rand(time_slots.count)
      time_slots[rand_num]
    end

    def is_available_slot?(time_slot_id)
      slot = TimeSlot.find(time_slot_id)
      slot.is_available
    end
  end
end
