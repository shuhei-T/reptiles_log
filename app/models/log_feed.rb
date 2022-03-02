class LogFeed < ApplicationRecord
  belongs_to :feed, optional: true
  belongs_to :log, optional: true

  validates :feed, presence: true, if: :feed_id?
  validates :log, presence: true, if: :log_id?
  validates :count, numericality: { greater_than_or_equal_to: 1, less_than: 10 }, allow_nil: true
  validate :required_feed_column


  private

  def required_feed_column
    return if feed_id.present? or log.remark.present? or log.condition.present? or log.shit.present? or log.bath.present? or log.handling.present? or log.creaning.present? or log.sheding.present? or log.weight.present? or log.length.present? or log.temperature.present? or log.humidity.present? or log.images.present?

    errors.add(:base, '入力してください')
  end
end
