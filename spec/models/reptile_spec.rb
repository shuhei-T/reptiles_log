require 'rails_helper'

RSpec.describe Reptile, type: :model do
  it 'is valid with all attributes' do
    reptile = build(:reptile)
    expect(reptile).to be_valid
    expect(reptile.errors).to be_empty
  end

  it 'is invalid without name' do
    reptile_without_name = build(:reptile, name: '')
    expect(reptile_without_name).to be_invalid
    expect(reptile_without_name.errors[:name]).to eq ["を入力してください"]
  end

  it 'is invalid name count over20' do
    reptile_name_count_over20 = build(:reptile, name: 'afeioahgfagfhaiefjiaj')
    expect(reptile_name_count_over20).to be_invalid
    expect(reptile_name_count_over20.errors[:name]).to eq ["は20文字以内で入力してください"]
  end

  it 'is invalid without user_id' do
    reptile_without_user = build(:reptile, user_id: '')
    expect(reptile_without_user).to be_invalid
    expect(Reptile.reflect_on_association(:user).macro).to eq :belongs_to
  end

  it 'is valid birthday before today' do
    reptile_birthday_today = create(:reptile, birthday: Date.today, adoptaversary: Date.today)
    reptile_birthday_before_today = create(:reptile, birthday: Date.today - 1, adoptaversary: Date.today)
    expect(Reptile.all.count).to eq 2
  end

  it 'is invalid birthday after today' do
    reptile_birthday_after_today = build(:reptile, birthday: Date.today + 1, adoptaversary: Date.today)
    expect(reptile_birthday_after_today).to be_invalid
    expect(reptile_birthday_after_today.errors[:birthday]).to include(": 「生年月日」を未来に設定することはできません")
  end

  it 'is valid birthday smaller adoptaversary' do
    reptile_birthday_equal_adoptaversary = create(:reptile, birthday: Date.today, adoptaversary: Date.today)
    reptile_birthday_smaller_adoptaversary = create(:reptile, birthday: Date.today - 1, adoptaversary: Date.today)
    expect(Reptile.all.count).to eq 2
  end

  it 'is invalid birthday bigger adoptaversary' do
    reptile_birthday_bigger_adoptaversary = build(:reptile, birthday: Date.today, adoptaversary: Date.today - 1)
    expect(reptile_birthday_bigger_adoptaversary).to be_invalid
    expect(reptile_birthday_bigger_adoptaversary.errors[:birthday]).to include(": 「お迎え日」より未来に設定することはできません")
  end
end
