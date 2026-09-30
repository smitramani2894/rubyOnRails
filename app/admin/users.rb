ActiveAdmin.register User do
  permit_params :name, :email, :age, :is_active

  index do
    selectable_column
    id_column
    column("Name") { |user| link_to user.name, admin_user_path(user) }
    column :email
    column :age
    column(:is_active) { |user| user.is_active? ? "Active" : "Inactive" }
    column :created_at
    column "Total Posts", :posts_count, sortable: :posts_count
    actions
  end

  filter :is_active
  filter :name
  filter :email
  filter :posts_count, as: :numeric, label: "Total Posts"
end
