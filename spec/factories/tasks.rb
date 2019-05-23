FactoryBot.define do
  factory :task do
    title { "MyTitle" }
    body { "MyBody" }
    price { 777555 }

    factory :task_sequence do
      sequence(:title) { |n| "MyTitle#{n}" }
      sequence(:body) { |n| "MyBody#{n}" }
      sequence(:price) { |n| 777 + n }
      association :author, factory: :user
    end

    trait :with_author do
      association :author, factory: :user
    end
  end
end
