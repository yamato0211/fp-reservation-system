# spec/models/financial_planner_spec.rb

require 'rails_helper'

RSpec.describe FinancialPlanner, type: :model do
  describe 'validations' do
    subject { FactoryBot.build(:financial_planner) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(20) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_least(1).is_at_most(400) }
    it { is_expected.to validate_length_of(:qualification).is_at_most(100) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:time_slots).dependent(:destroy) }
    it { is_expected.to have_many(:appointments).dependent(:destroy) }
  end
end
