FactoryBot.define do
  factory :comment do
    body { "Test comment" }

    factory :comment_sequence do
      sequence(:body) { |n| "Test comment#{n}" }
      association :author, factory: :user
    end

    trait :invalid do
      body { nil }
    end

    trait :with_task do
      association :author, factory: :user
      association :task, factory: [:task, :with_author]
    end
  end
end
