class UploadsController < ApplicationController
    def create
        puts "params #{params} upload_params #{upload_params}"
       
        user_id = upload_params[:user_id]
        image = upload_params[:image]
        puts "user id #{user_id} image #{uri_for(image)}"
    
        blob = ActiveStorage::Blob.create_and_upload!(
          io: image,
          filename: image.original_filename,
          content_type: image.content_type,
        )
    
        if user_id.present?
        user = User.find(user_id)
        user.image.attach(blob.signed_id)
        end

      end

      private
      def upload_params
        params.require(:upload).permit(:user_id, :image)
      end
end
