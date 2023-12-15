require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { FactoryBot.build(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(20) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_least(1).is_at_most(400) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:appointments).dependent(:destroy) }
  end
end
