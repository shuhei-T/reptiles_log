require 'rails_helper'

RSpec.describe "Charts", type: :system do
  let(:user) { create(:user) }
  let(:reptile) { create(:reptile, user: user) }
  let(:log) { create(:log, user: user, reptile: reptile) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context '飼育グラフにアクセス' do
        it '飼育カレンダーへのアクセスが失敗する' do
          visit reptile_charts_path(reptile)
          expect(current_path).to eq login_path
          expect(page).to have_content 'ログインしてください'
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user)}
    describe 'ページ遷移確認' do
      context '飼育グラフにアクセス' do
        it '飼育グラフへのアクセスが成功する' do
          visit reptile_charts_path(reptile)
          expect(current_path).to eq reptile_charts_path(reptile)
          expect(page).to have_content '飼育グラフ'
        end
      end
    end
  end
end
