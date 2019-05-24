FactoryBot.define do
  factory :comment do
    body { "test comment" }

    trait :invalid do
      body { nil }
    end

    trait :with_task do
      association :user, factory: [:user, :with_author]
    end
  end
end
