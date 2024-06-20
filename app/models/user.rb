class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Rails.application.routes.url_helpers
  
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: { care_seeker: 0, care_provider: 1}

  def image_url
    if self.image.attached?
      rails_blob_path(self.image.attachment, only_path: true)
    else
      nil
    end
  end

  def links 
    liked_user_ids = Like.where(user_id: self.id).map(&:liked_user_id)
    likes_me_user_ids = Like.where(liked_user_id: self.id).map(&:user_id)

    linked_ids = liked_user_ids.select{|id| likes_me_user_ids.include?(id)}
    linked_users = User.where(id: linked_ids)
  end
end
