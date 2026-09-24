module SessionAuthenticatable extend ActiveSupport::Concern
    included do
      helper_method :current_user # available this conroller method in VIEW
    end

    private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authenticate_user
        unless current_user
          redirect_to login_path, alert: "Please login first"
        end
    end
end
