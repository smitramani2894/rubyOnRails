class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project

   validates :user_id, uniqueness: {
    scope: :project_id
  }
 def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "user_id",
      "project_id",
      "created_at",
      "updated_at"
    ]
 end

  def self.ransackable_associations(auth_object = nil)
    [
      "user",
      "project"
    ]
  end
end
