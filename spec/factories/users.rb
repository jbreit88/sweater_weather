FactoryBot.define do
  pass = Faker::Internet.password
  factory :user do
    email { Faker::Internet.email }
    password { pass }
    password_confirmation { pass }
  end
end
