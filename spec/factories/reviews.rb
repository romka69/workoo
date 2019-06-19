FactoryBot.define do
  factory :review do
    for_user { nil }
    by_user { nil }
    body { "MyText" }

    trait :with_users do
      association :for_user, factory: :user
      association :by_user, factory: :user
      association :task, factory: [:task, :with_author]
    end
  end
end
