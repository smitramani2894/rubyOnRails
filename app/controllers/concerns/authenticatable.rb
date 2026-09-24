module Authenticatable extend ActiveSupport::Concern #  reusable group/container
  # included do # run this, when this container include in any controller
  #     before_action :authenticate_user # run this before run any controller action
  #   # we can also choose specific actions e.g , only: [:create, :update, :destroy]
  #   # we  can also add before_action in controller  until it is here
  # end

  private

  def authenticate_user # check that, user is authenticated or not
    header = request.headers["Authorization"] # get value of Authrization
    if header.blank? # if header authorization not found
    return render json: {
        error: "Authorization header missing!"
      }, status: :unauthorized
    end

    token = header.split(" ").last # split " " and get last value, that is token

    begin # begin/rescue =  try/catch

        decoded_token = JWT.decode(
          token,
          ENV["JWT_SECRET"], # READ SECRET KEY
           true, # VERIFY SIGNATURE
          { algorithm: "HS256" } # VERIFY ACCORDING THIS ALOGRITHM
        )

        user_id = decoded_token[0]["user_id"] # decoded_token comes in array of object strucutre
        @current_user = User.find(user_id)

    rescue JWT::DecodeError, ActiveRecord::RecordNotFound # if token wrong, not found, expired, or malformed while decoding
         render json: { error: "Invalid or expired token" },
             status: :unauthorized
    end

    def current_user
      @current_user # instance variable
    end
  end
end
