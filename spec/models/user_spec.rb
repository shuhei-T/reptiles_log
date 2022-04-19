require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'is invalid without name' do
      user_without_name = build(:user, name: '')
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to eq ["を入力してください"]
    end

    it 'is invalid name word count over20' do
      user_name_word_count_over20 = build(:user, name: 'dsfowewefhfioewtjdlfjwofjwoifjwoe')
      expect(user_name_word_count_over20).to be_invalid
      expect(user_name_word_count_over20.errors[:name]).to eq ["は30文字以内で入力してください"]
    end

    it 'is invalid without email' do
      user_without_email = build(:user, email: '')
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors[:email]).to eq ["を入力してください"]
    end

    it 'is invalid with a duplicate email' do
      user = create(:user)
      user_with_duplicated_email = build(:user, email: user.email)
      expect(user_with_duplicated_email).to be_invalid
      expect(user_with_duplicated_email.errors[:email]).to eq ["はすでに存在します"]
    end

    it 'is valid with another email' do
      user = create(:user)
      user_with_another_email = build(:user, email: 'another_email@example.com')
      expect(user_with_another_email).to be_valid
      expect(user_with_another_email.errors).to be_empty
    end

    it 'is invalid with contrary to email' do
      user_with_contrary_to_email1 = build(:user, email:'testemailexample.com')
      user_with_contrary_to_email2 = build(:user, email:'testemailexamplecom')
      user_with_contrary_to_email3 = build(:user, email:'testemail@examplecom')
      user_with_contrary_to_email4 = build(:user, email:'testemail@example.123')
      user_with_contrary_to_email5 = build(:user, email:'testemail@.com')
      expect(User.all.count).to eq 0
    end
  
    it 'is invalid without password' do
      user_without_password = build(:user, password: '', password_confirmation: '')
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors[:password]).to eq ["は3文字以上で入力してください"]
    end
  
    it 'is invalid password count less than 3characters' do
      user_password_count_less_than_3characters = build(:user, password: '12')
      expect(user_password_count_less_than_3characters).to be_invalid
      expect(user_password_count_less_than_3characters.errors[:password]).to eq ["は3文字以上で入力してください"]
    end
  end
end
