class Profile < ApplicationRecord
  belongs_to :user

  validates :bio, presence: true
  validates :user_id, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "bio",
      "user_id",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "user"
    ]
  end
end
