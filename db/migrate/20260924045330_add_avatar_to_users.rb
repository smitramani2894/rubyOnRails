class AddAvatarToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :bigint
    add_column :users, :avatar_updated_at, :datetime
  end
end
