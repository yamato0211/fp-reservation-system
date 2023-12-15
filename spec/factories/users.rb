FactoryBot.define do
  factory :user do
    name { 'test' }
    description { 'test' }
    email { Faker::Internet.unique.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
