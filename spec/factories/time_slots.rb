FactoryBot.define do
  factory :time_slot do
    association :financial_planner
    date { Date.current + 2.days }
    start_time { '10:00' }
    is_available { true }
  end
end
