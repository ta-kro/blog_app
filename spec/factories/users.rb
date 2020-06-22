FactoryBot.define do
  factory :user do
    name { "testuser" }
    sequence(:email) {|n| "testuser#{n}@example.com" }
    password { "testuser" }
    password_confirmation { "testuser" }
  end
end