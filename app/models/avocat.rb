class Avocat < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.search(search)
    where("location LIKE ?", "%{search}")
  end
end
