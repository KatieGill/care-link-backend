class MessagesController < ApplicationController
    before_action :authenticate_user!
    def create
        @message = Message.new(message_params)
        @message.user_id = current_user.id
        if @message.save
            render json: @message
        else
            render json: {
                error: @message.errors.full_messages.to_sentence
            }
        end

    end

    def update

    end

    private
    def message_params
        params.require(:message).permit(:conversation_id, :body, :read)
    end
end