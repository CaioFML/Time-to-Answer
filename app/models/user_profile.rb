class UserProfile < ApplicationRecord
  belongs_to :user

  # Active_storage
  has_one_attached :avatar
end
