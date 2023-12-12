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

  describe 'class methods' do
    describe '.get_pre_appointments_with_financial_planner_id' do
      let(:financial_planner) { create(:financial_planner) }
      let!(:pending_appointment) { create(:appointment, financial_planner:, status: 'pending') }
      let!(:confirmed_appointment) { create(:appointment, financial_planner:, status: 'confirmed') }

      it 'returns only pending appointments for a specific financial planner' do
        result = Appointment.get_pre_appointments_with_financial_planner_id(financial_planner.id)
        expect(result).to include(pending_appointment)
        expect(result).not_to include(confirmed_appointment)
      end
    end

    describe '.get_appointments_with_financial_planner_id' do
      let(:financial_planner) { create(:financial_planner) }
      let!(:confirmed_appointment) { create(:appointment, financial_planner:, status: 'confirmed') }

      it 'returns only confirmed appointments for a specific financial planner' do
        result = Appointment.get_appointments_with_financial_planner_id(financial_planner.id)
        expect(result).to include(confirmed_appointment)
      end
    end

    describe '.get_appointments_with_user_id' do
      let(:user) { create(:user) }
      let!(:confirmed_appointment) { create(:appointment, user:, status: 'confirmed') }

      it 'returns only confirmed appointments for a specific user' do
        result = Appointment.get_appointments_with_user_id(user.id)
        expect(result).to include(confirmed_appointment)
      end
    end

    describe '.get_pre_appointments_with_user_id' do
      let(:user) { create(:user) }
      let!(:pending_appointment) { create(:appointment, user:, status: 'pending') }

      it 'returns only pending appointments for a specific user' do
        result = Appointment.get_pre_appointments_with_user_id(user.id)
        expect(result).to include(pending_appointment)
      end
    end
  end
end
