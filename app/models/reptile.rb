class Reptile < ApplicationRecord
  has_many :logs, dependent: :destroy
  
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20 }

  mount_uploader :image, ImageUploader
  enum sex: { unknown: 0, male: 1, female: 2 }
end
