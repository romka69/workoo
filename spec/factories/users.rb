FactoryBot.define do
  factory :user do
    email { "testemail@testemail.test" }
    password { '123456' }
    password_confirmation { '123456' }
    association :role, factory: :role

    trait :executor do
      email { "testemail2@testemail.test" }
      association :role, factory: [:role, :executor]
    end
  end
end
