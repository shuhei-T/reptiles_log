FactoryBot.define do
  factory :log do
    logged_at { Date.today }
    remark {'テストメモ'}
    condition { 'smile' }
    shit { 'good' }
    bath { true }
    handling { true }
    creaning { true }
    weight { '200' }
    length { '300' }
    temperature { '26' }
    humidity { '60' }
    association :reptile
    association :user
  end
end
