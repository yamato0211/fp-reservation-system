class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :financial_planner
  belongs_to :time_slot

  enum status: { pending: 0, confirmed: 1, canceled: 2 }

  validates :user_id, presence: true
  validates :financial_planner_id, presence: true
  validates :time_slot_id, presence: true, uniqueness: true

  def formatted_datetime
    date = time_slot.date.strftime('%Y-%m-%d')
    time = time_slot.start_time
    "#{date}T#{time}:00"
  end
end
