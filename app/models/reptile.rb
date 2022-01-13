class Reptile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20 }
  validates :owner, presence: true
end
