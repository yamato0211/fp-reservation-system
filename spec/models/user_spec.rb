require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'new user model' do
    it 'user is not nil' do
      expect(User.new).not_to eq(nil)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:name) }
    it { is_expected.to validate_length_of(:description) }
  end
end
