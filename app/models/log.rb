class Log < ApplicationRecord
  belongs_to :user
  belongs_to :daily_record

  validates :bath, inclusion: [true, false]
  validates :handling, inclusion: [true, false]
  validates :creaning, inclusion: [true, false]

end
