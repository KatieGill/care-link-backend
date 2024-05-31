class UsersController < ApplicationController
  respond_to :json
  def role
    @users = User.where(role: "#{params[:role]}")
    data = @users.each do |user|
      UserSerializer.new(user).serializable_hash
    end
    if !data.empty?
    render json: {
      status: { code: 200, message: 'Success'},
      data: data
    }
  
    else
    render json: {
      status: { code: 404, message: 'Not Found'},
    }
    end
  end
end
