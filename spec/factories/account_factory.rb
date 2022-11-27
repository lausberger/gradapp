FactoryBot.define do
  factory :account do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'test@gmail.com' }
    password { '1234' }
    type { 'Student' }
  end
end
