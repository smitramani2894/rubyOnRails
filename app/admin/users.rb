ActiveAdmin.register User do
  permit_params :name, :email, :age, :is_active

    index do
    selectable_column
    id_column
    column :name
    column :email
    column :age
    column :is_active do |user|
      user.is_active? ? "Active" : "Inactive"
    end
    column :created_at
    actions
  end

  filter :is_active
end
