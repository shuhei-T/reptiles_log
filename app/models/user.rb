class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record?  ||  changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 30 }

  has_many :reptiles, dependent: :destroy
  has_many :logs
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  enum role: { general: 0, admin:1 }


  mount_uploader :avatar, AvatarUploader

  def own?(object)
    id == object.user_id
  end

  def follow(other_user)
    following << other_user
    # active_relationships.create!(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
    # active_relationships.find_by(followed_id: other_user.id)
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = 'ゲストユーザー'
      user.comment = 'ゲストユーザーアカウントです。実際にご利用になるにはご自身のアカウントが必要です。ログアウトしてから会員登録を行ってください。'
      user.password = ENV['SECRETS_TEST_ACCOUNT_PASS']
      user.password_confirmation = ENV['SECRETS_TEST_ACCOUNT_PASS']
    end
  end
end
