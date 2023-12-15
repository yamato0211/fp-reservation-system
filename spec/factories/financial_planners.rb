FactoryBot.define do
  factory :financial_planner do
    name { 'test' }
    description { 'test' }
    qualification { 'test' }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
