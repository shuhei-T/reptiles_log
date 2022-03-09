class Log < ApplicationRecord
  has_many :log_feeds, dependent: :destroy
  has_many :feeds, through: :log_feeds
  belongs_to :user
  belongs_to :reptile
  accepts_nested_attributes_for :log_feeds, allow_destroy: true
  validates_associated :log_feeds

  validates :bath, inclusion: [true, false]
  validates :handling, inclusion: [true, false]
  validates :creaning, inclusion: [true, false]
  validates :weight, numericality: { greater_than_or_equal_to: 1, less_than: 100000 }, allow_nil: true
  validates :length, numericality: { greater_than_or_equal_to: 1, less_than: 100000 }, allow_nil: true
  validates :temperature, numericality: { greater_than_or_equal_to: 1, less_than: 100 }, allow_nil: true
  validates :humidity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }, allow_nil: true

  mount_uploaders :images, ImagesUploader

  enum condition: { smile: 0, meh: 1, tired: 2 }
  enum shit: { good: 0, bad: 1 }
  enum sheding: { shed: 0, white: 1 }
end
