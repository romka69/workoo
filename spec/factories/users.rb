FactoryBot.define do
  sequence :email do |n|
    "testemail#{n}@testemail.test"
  end

  factory :user do
    email
    password { '123456' }
    password_confirmation { '123456' }
    association :role, factory: :role

    trait :executor do
      email
      association :role, factory: [:role, :executor]
    end
  end
end
