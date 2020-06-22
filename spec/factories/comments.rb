FactoryBot.define do
  factory :comment do
    body { "My first comment." }
    association :post
  end
end
