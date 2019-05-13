FactoryBot.define do
  factory :task do
    title { "MyTitle" }
    body { "MyBody" }
    price { 777555 }

    factory :task_sequence do
      sequence(:title) { |n| "MyTitle#{n}" }
      sequence(:body) { |n| "MyBody#{n}" }
      sequence(:price) { |n| 777 + n }
    end
  end
end
