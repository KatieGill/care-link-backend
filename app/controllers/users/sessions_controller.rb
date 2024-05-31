# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json
  
  private
  
  def respond_with(resource, _opts = {})
    if current_user
      if current_user.image.attached?
      userData = current_user.as_json.merge(image_url: url_for(current_user.image))
      else
        userData = current_user.as_json
      end
      render json: {
      status: { code: 200, message: 'Logged in successfully.'},
      data: userData
      # data: UserSerializer.new(userData).serializable_hash[:data][:attributes]
    }
  end    
end

  # def respond_to_on_destroy
  #   if request.headers['Authorization'].present?
  #     jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last,
  #     Rails.application.credentials.devise_jwt_secret_key!).first
  #     current_user = User.find(jwt_payload['sub'])
  #   end
  #   if current_user
  #     render json: {
  #       status: 200,
  #       message: 'Logged out successfully.'
  #     }, status: :ok
  #   else
  #     render json: {
  #       status: 401,
  #       message: "Could not find session."
  #     }, status: :unauthorized
  #   end
  # end
  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
