class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[username first_name last_name zip_code role display_picture])
        devise_parameter_sanitizer.permit(:account_update, keys: %i[username first_name last_name zip_code role display_picture])
    end
end
