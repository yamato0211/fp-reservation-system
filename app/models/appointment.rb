class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :financial_planner
  belongs_to :time_slot

  enum status: { pending: 0, confirmed: 1, canceled: 2 }

  validates :user_id, presence: true
  validates :financial_planner_id, presence: true
  validates :time_slot_id, presence: true, uniqueness: true

  scope :desc, -> { order(created_at: :desc) }
  scope :pending, -> { where(status: :pending) }
  scope :confirmed, -> { where(status: :confirmed) }

  def self.get_pre_appointments_with_financial_planner_id(financial_planner_id)
    Appointment.all.where(financial_planner_id:).pending.desc
  end

  def self.get_appointments_with_financial_planner_id(financial_planner_id)
    Appointment.all.where(financial_planner_id:).confirmed.desc
  end

  def self.get_appointments_with_user_id(user_id)
    Appointment.all.where(user_id:).confirmed.desc
  end

  def self.get_pre_appointments_with_user_id(user_id)
    Appointment.all.where(user_id:).pending.desc
  end
end
