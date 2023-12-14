require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'validations' do
    subject { FactoryBot.create(:appointment) }

    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:financial_planner_id) }
    it { is_expected.to validate_presence_of(:time_slot_id) }
    it { is_expected.to validate_uniqueness_of(:time_slot_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:financial_planner) }
    it { is_expected.to belong_to(:time_slot) }
  end
end
