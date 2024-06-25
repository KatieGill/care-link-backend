class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user
      render json: current_user, except: [:created_at, :updated_at, :jti], methods: [:image_url, :number_of_links]
    else 
      render json: {
        status: { code: 401, message: "#{current_user.errors.full_messages.to_sentence}"}
      }
    end
  end

  def update
    if current_user.update(current_user_params)
      
      render json: current_user, except: [:created_at, :updated_at, :jti], methods: [:image_url, :number_of_links]
    
    else 
      render json: {
        status: { code: 401, message: "#{current_user.errors.full_messages.to_sentence}"}
      }
    end
  end

  def links
    @links = current_user.links

    if @links
      render json: @links, except: [:created_at, :updated_at, :jti], methods: [:image_url, :number_of_links]
    
      else
      render json: {
        status: 404,
        error: "Links not found"
      }
      end
  end

  def open_conversation
    id = params[:id]
    conversation = Conversation.between(id, current_user.id)
    if conversation.size > 0 
      @conversation = conversation.first
    else
      @conversation = Conversation.new(recipient_id: id, sender_id: current_user.id)
      @conversation.save
    end
    @messages = @conversation.messages

    if @conversation
      render json: {
        conversation: @conversation,
        messages: @messages
      }
    else
      render json: {
        error: @conversation.errors.full_messages.to_sentence
      }
    end
  end

  private
  def current_user_params
    params.require(:current_user).permit(:email, :username, :first_name, :last_name, :zip_code, :role, :image, :number_of_children, :years_experience, :pay, :bio)
  end
end
