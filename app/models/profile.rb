class Profile < ApplicationRecord
  belongs_to :user

  validates :bio, presence: true
  validates :user_id, uniqueness: true
end
