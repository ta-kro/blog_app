FactoryBot.define do
  factory :post do
    content { "My first post." }
    association :user
  end
end
