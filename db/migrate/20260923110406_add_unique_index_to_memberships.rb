class AddUniqueIndexToMemberships < ActiveRecord::Migration[8.1]
  def change
     add_index :memberships,
              [ :user_id, :project_id ],
              unique: true
  end
end
