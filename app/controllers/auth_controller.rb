class AuthController < ApplicationController
    def register
        user = User.new(user_params)

        if user.save
          render json: {
            message: "user registered successfully!",
            user: {
                id: user.id,
                name: user.name,
                email: user.email,
                age: user.age,
                is_active: user.is_active
            },
            status: :created
        }

        else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end


    def login
        user = User.find_by(email: params[:email])

      if user && user.authenticate(params[:password])
        token = JWT.encode(
            {
                user_id: user.id,
                exp: 24.hour.from_now.to_i
            },
            ENV["JWT_SECRET"],
            "HS256"
        )

        render json: {
            message: "user login successfully!",
            user: {
                id: user.id,
                name: user.name,
                email: user.email
            },
            token: token
        }
      else
        render json: {   error: "Invalid email or password" }, status: :unauthorized
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :age, :password)
    end
end
