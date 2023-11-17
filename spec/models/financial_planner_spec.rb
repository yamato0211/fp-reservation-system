require 'rails_helper'

RSpec.describe FinancialPlanner, type: :model do
  describe 'new financial_planner model' do
    it 'financial_planner is not nil' do
      expect(FinancialPlanner.new).not_to eq(nil)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:name) }
    it { is_expected.to validate_length_of(:description) }
    it { is_expected.to validate_length_of(:qualification) }
    # it { is_expected.to validate_uniqueness_of(:email) }
  end
end
