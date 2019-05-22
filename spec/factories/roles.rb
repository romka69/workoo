FactoryBot.define do
  factory :role do
    role_name { "customer" }

    trait :executor do
      role_name { "executor" }
    end
  end
end
