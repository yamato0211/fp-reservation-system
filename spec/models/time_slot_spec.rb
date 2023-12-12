require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  describe 'validations' do
    subject { FactoryBot.build(:time_slot) }

    it { is_expected.to validate_presence_of(:financial_planner_id) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_uniqueness_of(:financial_planner_id).scoped_to(:date, :start_time) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:financial_planner) }
    it { is_expected.to have_one(:appointment) }
  end

  describe 'class methods' do
    describe '.time_slots_after_three_month' do
      let(:financial_planner) { FactoryBot.create(:financial_planner) }
      let!(:time_slot) { FactoryBot.create(:time_slot, financial_planner:) }

      it 'returns time slots for the next three months for a specific financial planner' do
        result = TimeSlot.time_slots_after_three_month(financial_planner.id)
        key = "#{time_slot.date.strftime('%Y-%m-%d')}_#{time_slot.start_time}"
        expect(result).to have_key(key)
        expect(result[key]).to eq({ date: time_slot.date.strftime('%Y-%m-%d'), start_time: time_slot.start_time })
      end
    end

    describe '.time_slot_available?' do
      let(:date) { Date.current + 1.day }
      let(:start_time) { '10:00' }
      let(:time_slots) { { "#{date}_#{start_time}" => { date:, start_time: } } }

      it 'returns true if a time slot is available' do
        expect(TimeSlot.time_slot_available?(time_slots, date, start_time)).to be true
      end
    end

    describe '.available_time_with_date' do
      let(:financial_planner) { FactoryBot.create(:financial_planner) }
      let(:date) { Date.current + 1.day }
      let!(:time_slot) { FactoryBot.create(:time_slot, financial_planner:, date:) }

      it 'returns available time slots for a specific date and financial planner' do
        expect(TimeSlot.available_time_with_date(date, financial_planner.id)).to include(time_slot.start_time)
      end
    end

    describe '.available_appointment_time_slots' do
      let!(:time_slot) { FactoryBot.create(:time_slot) }

      it 'returns available appointment time slots' do
        result = TimeSlot.available_appointment_time_slots
        key = "#{time_slot.date.strftime('%Y-%m-%d')}_#{time_slot.start_time}"
        expect(result[key]).to eq({ date: time_slot.date.strftime('%Y-%m-%d'), start_time: time_slot.start_time })
      end
    end

    describe '.appointment_time_slot_available?' do
      let(:date) { Date.current }
      let(:start_time) { '10:00' }
      let(:time_slots) { { "#{date}_#{start_time}" => { date:, start_time: } } }

      it 'returns true if an appointment time slot is available' do
        expect(TimeSlot.appointment_time_slot_available?(time_slots, date, start_time)).to be true
      end
    end

    describe '.pre_register_time_slot' do
      let(:date) { Date.current + 1.day }
      let(:start_time) { '10:00' }
      let!(:time_slot) { FactoryBot.create(:time_slot, date:, start_time:) }

      it 'returns a pre-registered time slot' do
        expect(TimeSlot.pre_register_time_slot(date, start_time)).to eq(time_slot)
      end
    end

    describe '.is_available_slot?' do
      let!(:time_slot) { FactoryBot.create(:time_slot) }

      it 'returns true if the time slot is available' do
        expect(TimeSlot.is_available_slot?(time_slot.id)).to be true
      end
    end
  end
end
