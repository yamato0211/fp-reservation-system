class FinancialPlanner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :time_slots, dependent: :destroy
  has_many :appointments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 1, maximum: 400 }
  validates :qualification, length: { maximum: 100 }
end
