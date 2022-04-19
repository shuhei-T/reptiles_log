require 'rails_helper'

RSpec.describe "Contacts", type: :system do
  describe 'ページ遷移確認' do
    context 'お問い合わせページにアクセス' do
      it 'お問い合わせページへのアクセスに成功する' do
        visit new_contact_path
        expect(current_path).to eq new_contact_path
        expect(page).to have_content "お問い合わせ"
      end
    end
  end
  describe 'お問い合わせ機能' do
    context 'フォームの入力値が正常' do
      it 'お問い合わせフォームへの送信が成功する' do
        visit new_contact_path
        fill_in '名前', with: 'テストユーザー'
        fill_in 'メールアドレス', with: 'sample@example.com'
        fill_in 'お問い合わせ内容', with: 'テスト'
        click_button '送信'
        expect(current_path).to eq new_contact_path
        expect(page).to have_content 'お問い合わせメールを送信しました'
      end
    end
    context '名前が未入力' do
      it 'お問い合わせフォームへの送信が失敗する' do
        visit new_contact_path
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: 'sample@example.com'
        fill_in 'お問い合わせ内容', with: 'テスト'
        click_button '送信'
        expect(current_path).to eq contacts_path
        expect(page).to have_content 'お問い合わせメールの送信に失敗しました'
        expect(page).to have_content '名前を入力してください'
      end
    end
    context 'メールアドレスが未入力' do
      it 'お問い合わせフォームへの送信が失敗する' do
        visit new_contact_path
        fill_in '名前', with: 'テストユーザー'
        fill_in 'メールアドレス', with: ''
        fill_in 'お問い合わせ内容', with: 'テスト'
        click_button '送信'
        expect(current_path).to eq contacts_path
        expect(page).to have_content 'お問い合わせメールの送信に失敗しました'
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end
    context 'お問い合わせ内容が未入力' do
      it 'お問い合わせフォームへの送信が失敗する' do
        visit new_contact_path
        fill_in '名前', with: 'テストユーザー'
        fill_in 'メールアドレス', with: 'sample@example.com'
        fill_in 'お問い合わせ内容', with: ''
        click_button '送信'
        expect(current_path).to eq contacts_path
        expect(page).to have_content 'お問い合わせメールの送信に失敗しました'
        expect(page).to have_content 'お問い合わせ内容を入力してください'
      end
    end
  end
end
