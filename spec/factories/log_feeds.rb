FactoryBot.define do
  factory :log_feed do
    count { '2' }
    size { 'M' }
    association :log
    association :feed
  end
end