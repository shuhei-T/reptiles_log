class LogFeed < ApplicationRecord
  belongs_to :feed, optional: true
  belongs_to :log, optional: true

  validates :feed, presence: true, if: :feed_id?
  validates :log, presence: true, if: :log_id?
end
