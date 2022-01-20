class DailyRecord < ApplicationRecord
  belongs_to :reptile

  validates :take_care_time, presence: true
end
