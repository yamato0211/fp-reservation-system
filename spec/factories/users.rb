FactoryBot.define do
  factory :user do
    name { 'test' }
    description { 'test' }
    email { 'test@mail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
