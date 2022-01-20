class LogFeed < ApplicationRecord
  belongs_to :feed
  belongs_to :log
end
