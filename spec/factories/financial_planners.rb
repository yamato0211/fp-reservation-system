FactoryBot.define do
  factory :financial_planner do
    name { 'test' }
    description { 'test' }
    qualification { 'test' }
    email { 'test@mail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
