class UsersController < ApplicationController
  respond_to :json
  def role
    @users = User.where(role: "#{params[:role]}")

    if @users
    render json: @users, except: [:created_at, :updated_at, :jti], methods: [:image_url]
  
    else
    render json: {
      status: { code: 404, message: 'Not Found'},
    }
    end
  end
end
