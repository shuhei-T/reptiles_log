RSpec.configure do |config|
  config.before(:each, type: :system) do
    # spec実行時、ブラウザが自動で立ち上がり挙動を確認できる
    # driven_by :selenium_chrome

    # spec実行時、ブラウザoff
    driven_by :selenium_chrome_headless
  end
end
