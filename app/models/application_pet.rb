class ApplicationPet < ApplicationRecord
  has_many :pets
  has_many :applications
end
