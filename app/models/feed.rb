class Feed < ApplicationRecord
  has_many :log_feeds, dependent: :destroy

  validates :name, presence: true
end
