class Reptile < ApplicationRecord
  has_many :logs, dependent: :destroy
  
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20 }
  validate :date_valid?

  mount_uploader :image, ImageUploader
  enum sex: { unknown: 0, male: 1, female: 2 }


  private

  def date_valid?
    if birthday.present? && birthday > Date.today
      errors.add(:birthday, ": 「生年月日」を未来に設定することはできません")
    end
    if adoptaversary.present? && adoptaversary > Date.today
      errors.add(:adoptaversary, ": 「お迎え日」を未来に設定することはできません")
    end
    if birthday.present? && adoptaversary.present? && birthday > adoptaversary
      errors.add(:birthday, ": 「お迎え日」より未来に設定することはできません")
      errors.add(:adoptaversary, ": 「生年月日」より過去に設定することはできません")
    end
  end
end
