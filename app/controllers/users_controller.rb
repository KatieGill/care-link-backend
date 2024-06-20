class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  def role
    liked_user_ids = Like.where(user_id: current_user.id).map(&:liked_user_id)
    disliked_user_ids = Dislike.where(user_id: current_user.id).map(&:disliked_user_id)
   
    @users = User.where(role: "#{params[:role]}").where.not(id: liked_user_ids).where.not(id: disliked_user_ids)

    if @users
    render json: @users, except: [:created_at, :updated_at, :jti], methods: [:image_url]
  
    else
    render json: {
      status: 404,
      error: "User not found"
    }
    end
    
  end

  def approve
    user_id = params[:id]
    new_like = Like.new(liked_user_id: user_id)
    new_like.user_id = current_user.id

    if new_like.save
      # existing_like = Like.where(user_id: user_id, liked_user_id: current_user.id).count
      # @they_like_use = existing_like > 0
      render json: {
        status: 200,
        message: "You liked this user"
      
      }
    else
      render json: {
        status: 404,
        error: "Unable to like user"
      }
    end
  end

  def decline
    user_id = params[:id]
    new_dislike = Dislike.new(disliked_user_id: user_id)
    new_dislike.user_id = current_user.id

    if new_dislike.save 
      render json: {
        status: 200,
        message: "You disliked this user"
      }
    else
      render json: {
        status: 404,
        error: "Unable to dislike user"
      }
    end
  
  end

  private
  def user_params
    params.require(:user).permit(:id)
  end
end
