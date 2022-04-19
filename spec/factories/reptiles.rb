FactoryBot.define do
  factory :reptile do
    sequence(:name) { |n| "reptile-#{n}" }
    reptile_category { 'テストカテゴリ' }
    morph { 'testmorph' }
    sex { 'male' }
    birthday { '2015-01-01' }
    adoptaversary { '2016-01-01' }
    comment { 'テストコメント' }
    association :user
  end
end
