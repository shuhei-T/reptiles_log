class Reptile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20 }

  enum sex: { unknown: 0, male: 1, female: 2 }
end
