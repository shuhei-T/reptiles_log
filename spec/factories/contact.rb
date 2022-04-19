FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "contact-#{n}" }
    sequence(:email) { |n| "contact_#{n}@example.com" }
    message { 'テストメッセージ' }
  end
end
