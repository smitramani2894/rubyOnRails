class UsersController < ApplicationController
   include SessionAuthenticatable
   before_action :authenticate_user, only: [ :edit, :update, :destroy, :show ]
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def index
  @users =
      case params[:status]
      when "active"
        User.active.includes(:posts)
      when "inactive"
        User.inactive.includes(:posts)
      else
        User.all.includes(:posts)
      end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
       redirect_to users_path, notice: "User created successfully!"
    else
       render :new, status: :unprocessable_entity
    end
  end


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
        redirect_to user_path(@user), notice: "User updated successfully!"
    else
       render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to users_path, notice: "User deleted successfully!"
    else
      redirect_to users_path, notice: "User couldn't be deleted"
    end
  end

  private

  def user_params
  params.require(:user).permit(
    :name,
    :email,
    :age,
    :is_active,
    :password,
    :password_confirmation,
    :avatar,
  )
  end

    def user_not_found
    render json: { error: "User not found, ID : #{params[:id]}" }, status: :not_found
    end
end
