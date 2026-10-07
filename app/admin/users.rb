ActiveAdmin.register User do
  menu priority: 1, parent: "Management", label: "Users"
  permit_params :name,
                :email,
                :age,
                :is_active,
                :password,
                :password_confirmation

  scope :all
  scope :active
  scope :inactive

  collection_action :export, method: :get do
    @users = User.all

    respond_to do |format|
      format.xlsx do
        package = Axlsx::Package.new
        workbook = package.workbook

        workbook.add_worksheet(name: "Users") do |sheet|
          sheet.add_row %w[ID Name Email Age Status]
          @users.each do |user|
            sheet.add_row [
                            user.id,
                            user.name,
                            user.email,
                            user.age,
                            user.is_active? ? "Active" : "Inactive",
                          ]
          end
        end
        send_data package.to_stream.read,
                  filename: "users.xlsx",
                  type:
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      end
    end
  end

  member_action :deactivate, method: :put do
    @user = User.find(params[:id])
    @user.update!(is_active: false)

    redirect_back(
      fallback_location: admin_users_path,
      notice: "User deactivated"
    )
  end

  member_action :activate, method: :put do
    @user = User.find(params[:id])
    @user.update!(is_active: true)

    redirect_back(fallback_location: admin_users_path, notice: "User activated")
  end

  action_item :export_users, only: :index do
    link_to "Export Users", export_admin_users_path(format: :xlsx)
  end

  index do
    selectable_column
    id_column
    column("Name") { |user| link_to user.name, admin_user_path(user) }
    column :email
    column :age
    column(:is_active) { |user| user.is_active? ? "Active" : "Inactive" }
    column :created_at
    column "Total Posts", :posts_count, sortable: :posts_count

    actions name: "Active/Deactive", defaults: false do |user|
      if user.is_active?
        item "<i class='fa fa-ban' title='Deactive'></i>".html_safe,
             deactivate_admin_user_path(user),
             method: :put,
             data: {
               confirm: "Are you sure you want to deactivate this user?"
             }
      else
        item "<i class='fa fa-check' title='Active'></i>".html_safe,
             activate_admin_user_path(user),
             method: :put,
             data: {
               confirm: "Are you sure you want to activate this user?"
             }
      end
    end

    actions name: "Actions", defaults: false do |user|
      item "<i class='fa fa-eye primary'></i>".html_safe,
           admin_user_path(user),
           title: "View"

      item "<i class='fa fa-pencil success'></i>".html_safe,
           edit_admin_user_path(user),
           title: "Edit"

      item "<i class='fa fa-trash danger'></i>".html_safe,
           admin_user_path(user),
           method: :delete,
           data: {
             confirm: "Are you sure?"
           },
           title: "Delete",
           class: "text-red-600 hover:text-red-800"
    end
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :age
      row :posts_count
      row :is_active do |user|
        user.is_active? ? "Active" : "Inactive"
      end
      row :created_at
    end
  end

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :age
      f.input :is_active
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end

  filter :is_active
  filter :name
  filter :email
  filter :posts_count, as: :numeric, label: "Total Posts"
end
