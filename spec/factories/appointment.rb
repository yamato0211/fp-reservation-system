FactoryBot.define do
  factory :appointment do
    association :user
    association :financial_planner
    association :time_slot

    status { 'pending' }
  end
end
