class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user
    render json: {
      status: { code: 200, message: 'Success'},
      data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
    }
    else 
    render json: {
      status: { code: 401, message: "#{current_user.errors.full_messages.to_sentence}"}
    }
    end
  end

  def update
    if current_user.update(current_user_params)
      render json: {
        status: { code: 200, message: 'Success'},
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
    }
    else 
    render json: {
      status: { code: 401, message: "#{current_user.errors.full_messages.to_sentence}"}
    }
    end
  end

  private
  def current_user_params
    params.require(:current_user).permit(:email, :username, :first_name, :last_name, :zip_code, :role, :display_picture, :number_of_children, :years_experience, :pay, :bio)
  end
end
