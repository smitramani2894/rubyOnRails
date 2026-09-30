class Post < ApplicationRecord
belongs_to :user, counter_cache: true

   validates :title, presence: true
   validates :content, presence: true

     def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "title",
      "content",
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
