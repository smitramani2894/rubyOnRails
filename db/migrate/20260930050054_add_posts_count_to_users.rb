class AddPostsCountToUsers < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :posts_count, :integer, default: 0, null: false
    User.reset_column_information
    User.find_each { |u| User.reset_counters(u.id, :posts) }
  end

  def down
    remove_column :users, :posts_count
  end
end
