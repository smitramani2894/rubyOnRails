ActiveAdmin.register User do
  permit_params :name, :email, :age, :is_active

    controller do
      def scoped_collection
        User.left_joins(:posts)
        .group("users.id")
        .select("users.*,COUNT(posts.id) as posts_count")
      end
    end

    index do
    selectable_column
    id_column
    column "Name" do |user|
      link_to user.name, admin_user_path(user)
    end
    column :email
    column :age
    column :is_active do |user|
      user.is_active? ? "Active" : "Inactive"
    end
    column :created_at
    column "Total Posts" do |user|
      user.posts_count
    end

    actions
  end

  filter :is_active
  filter :name
  filter :email
end
