require "rails_helper"

RSpec.describe TimeSlot, type: :model do
  describe "new time_slot model" do
    it "time_slot is not nil" do
      expect(TimeSlot.new).not_to eq(nil)
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:financial_planner_id) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:start_time )}
    it { is_expected.to validate_presence_of(:end_time) }
    # it { is_expected.to validate_uniqueness_of(:financial_planner_id).scoped_to([:date, :start_time]) }
  end
end
