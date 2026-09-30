class User < ApplicationRecord
    has_attached_file :avatar # this model has file attachment called avatar
    has_secure_password

    has_many :posts, dependent: :destroy
    has_one :profile, dependent: :destroy
    has_many :memberships, dependent: :destroy
    has_many :projects, through: :memberships

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :age, numericality: { greater_than_or_equal_to: 13 }
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
    # content_tyept: check MIME/content type  e.g : image/png,/jpeg,/gif,text/plain, application/pdf
    # /\Aimage\/.*\z/ : should start with image/png,jpeg,gif,webp

    scope :active, -> { where(is_active: true) }
    scope :inactive, -> { where(is_active: false) }
    scope :adults, -> { where("age >= ?", 18) }


  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "name",
      "email",
      "age",
      "is_active",
      "created_at",
      "updated_at",
       "posts_count"
    ]
  end
   def self.ransackable_associations(auth_object = nil)
    [
      "memberships",
      "posts",
      "profile",
      "projects"
    ]
   end
end
