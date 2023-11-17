require "rails_helper"

RSpec.describe User, type: :model do
    describe "new user model" do
        it "user is not nil" do
            expect(User.new).not_to eq(nil)
        end
    end

    describe "validations" do
        it { should validate_presence_of :name }
        it { should validate_presence_of :description }
        it { should validate_presence_of :email }
        it { should validate_presence_of :password }
        it { should validate_length_of :name }
        it { should validate_length_of :description }
    end
end