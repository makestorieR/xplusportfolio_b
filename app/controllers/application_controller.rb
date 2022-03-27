class ApplicationController < ActionController::API
        include Pagy::Backend
        before_action :configure_permitted_parameters, if: :devise_controller?
        include DeviseTokenAuth::Concerns::SetUserByToken
        include ActionController::ImplicitRender # if you need render .jbuilder
        include ActionView::Layouts # if you need layout for .jbuilder
        
        protected

        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :registraion, :email, :password_confirmation, :github_url, :avatar_url])
        end
end
