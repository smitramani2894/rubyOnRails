module UsersHelper
  def user_status(user)
    user.is_active ? "Active" : "Inactive"
  end
end
