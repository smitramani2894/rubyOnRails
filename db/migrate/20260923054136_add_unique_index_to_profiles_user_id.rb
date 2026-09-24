class AddUniqueIndexToProfilesUserId < ActiveRecord::Migration[8.1]
  def change
     remove_index :profiles, :user_id
    add_index :profiles, :user_id, unique: true
  end
end
