class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: { care_seeker: 0, care_provider: 1}

  def image_url
    if self.image.attached
    self.image.attachment.url
    else
      "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}"
    end
  end
end
