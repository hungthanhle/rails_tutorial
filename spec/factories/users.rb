FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
