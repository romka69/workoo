FactoryBot.define do
  factory :bid do
    association :user, factory: [:user, :executor]
    association :task, factory: [:task, :with_author]
  end
end
