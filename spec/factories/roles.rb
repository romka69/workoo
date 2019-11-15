FactoryBot.define do
  factory :role do
    role_name { "customer" }

    trait :executor do
      role_name { "executor" }
    end

    trait :not_selected do
      role_name { "not selected" }
    end
  end
end
