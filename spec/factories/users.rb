FactoryBot.define do
  sequence :email do |n|
    "testemail#{n}@testemail.test"
  end

  factory :user do
    email
    password { '123456' }
    password_confirmation { '123456' }
    first_name { 'Name_test' }
    last_name { 'Last_name_test' }
    city { 'City_test' }
    birth_date { '21-04-2016' }
    about { 'Test about' }
    association :role, factory: :role

    trait :executor do
      email
      association :role, factory: [:role, :executor]
    end
  end
end
