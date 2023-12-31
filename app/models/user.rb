class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :appointments, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 1, maximum: 400 }
end
