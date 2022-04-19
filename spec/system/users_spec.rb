require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe '新規アカウント作成' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規登録が成功する' do
          visit new_user_path
          fill_in 'ユーザー名', with: 'テストユーザー'
          fill_in 'メールアドレス', with: 'test@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button 'アカウントを作成する'
          expect(page).to have_content 'ユーザー登録が完了しました'
          expect(current_path).to eq reptiles_path
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規登録が失敗する' do
          visit new_user_path
          fill_in 'ユーザー名', with: 'テストユーザー'
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button 'アカウントを作成する'
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(current_path).to eq  new_user_path
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規登録が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in 'ユーザー名', with: 'テストユーザー'
          fill_in 'メールアドレス', with: existed_user.email
          fill_in 'パスワード', with: 'パスワード'
          fill_in 'パスワード確認', with: 'パスワード'
          click_button 'アカウントを作成する'
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(current_path).to eq new_user_path
        end
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do
          visit profile_path
          expect(page).to have_content 'ログインしてください'
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          visit edit_profile_path
          fill_in 'ユーザー名', with: 'アップデートユーザー'
          fill_in 'メールアドレス', with: 'update@example.com'
          click_button '保存'
          expect(page).to have_content 'ユーザーを更新しました'
          expect(current_path).to eq profile_path
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する' do
          visit edit_profile_path
          fill_in 'ユーザー名', with: 'アップデートユーザー'
          fill_in 'メールアドレス', with: ''
          click_button '保存'
          expect(page).to have_content 'ユーザーを更新できませんでした'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(current_path).to eq profile_path
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          visit edit_profile_path
          other_user = create(:user)
          fill_in 'ユーザー名', with: 'アップデートユーザー'
          fill_in 'メールアドレス', with: other_user.email
          click_button '保存'
          expect(page).to have_content 'ユーザーを更新できませんでした'
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(current_path).to eq  profile_path
        end
      end
    end
  end
end
