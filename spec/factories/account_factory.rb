# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'jdoe@gmail.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
    account_type { 'Student' }
    trait :faculty do
      account_type { 'Faculty' }
    end
    trait :department_chair do
      account_type { 'Department Chair' }
    end
  end
end
