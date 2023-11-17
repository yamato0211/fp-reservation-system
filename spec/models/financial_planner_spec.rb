require "rails_helper"

RSpec.describe FinancialPlanner, type: :model do
    describe "new financial_planner model" do
        it "financial_planner is not nil" do
            expect(FinancialPlanner.new).not_to eq(nil)
        end
    end

    describe "validations" do
        it { should validate_presence_of :name }
        it { should validate_presence_of :description }
        it { should validate_presence_of :email }
        it { should validate_presence_of :password }
        it { should validate_length_of :name }
        it { should validate_length_of :description }
        it { should validate_length_of :qualification }
    end
end