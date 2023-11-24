class TimeSlot < ApplicationRecord
  belongs_to :financial_planner
  has_one :appointment

  validates :financial_planner_id, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :financial_planner_id, uniqueness: { scope: %i[date start_time] }
end
