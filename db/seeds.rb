# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Feed.count == 0
  Feed.create! [
    { name: 'フタホシコオロギ'},
    { name: 'ヨーロッパイエコオロギ'},
    { name: 'デュビア'},
    { name: 'レッドローチ'},
    { name: 'ワーム'},
    { name: 'ピンクマウス'},
    { name: 'ファジーマウス'},
    { name: 'ホッパーマウス'},
    { name: 'アダルトマウス'},
    { name: 'リタイアマウス'},
    { name: 'ピンクラット'},
    { name: 'ファジーラット'},
    { name: 'ホッパーラット'},
    { name: 'アダルトラット'},
    { name: 'リタイアラット'},
    { name: '人工飼料'},
    { name: '野菜'},
    { name: 'フルーツ'},
    { name: 'ヒヨコ'},
  ]
end

# 50.times do
# User.create!(
#   name: Faker::Name.unique.name,
#   email: Faker::Internet.unique.email,
#   password: "1234",
#   password_confirmation: '1234'
# )
# end

# users = User.all
# user = User.first
# following = users[1..25]
# followers = users[3..25]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }

20.times do |index|
  Reptile.create!(
    user: User.first,
    name: Faker::Creature::Animal.unique.name,
    morph: 'テスト',
    sex: 'unknown',
    comment: "コメント#{index}",
    
  )
end