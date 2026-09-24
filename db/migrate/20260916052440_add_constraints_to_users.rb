class AddConstraintsToUsers < ActiveRecord::Migration[8.1]
  def change
      change_column_null :users, :name, false
      change_column_null :users, :email, false
      add_index :users, :email, unique: true
      change_column_default :users, :is_active, from: nil, to: true
      add_check_constraint :users, "age >=13", name: "users_age_check"
  end
end
