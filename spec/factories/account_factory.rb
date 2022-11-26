FactoryBot.define do
  factory :account do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'jdoe@gmail.com' }
    password { '1234' }
    type { 'Student' }
  end
end
