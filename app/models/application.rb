class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :description, presence: true
  validates :status, presence: true, numericality: true

  has_many :application_pets
  has_many :pets, through: :application_pets

  enum :status, [ :In_progress, :Pending, :Accepted, :Rejected ]
end
