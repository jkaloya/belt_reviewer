class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
    def require_login
        redirect_to '/' if session[:user_id] == nil
    end
    def require_correct_user
        user = User.find(params[:id])
        redirect_to "/events" if current_user != user
    end
    def initialize_flash
        if !flash[:errors]
          flash[:errors] = []
        end
    end

  protect_from_forgery with: :exception
end
