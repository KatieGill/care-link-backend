class UserSerializer
  include JSONAPI::Serializer
  # include Rails.application.routes.url_helpers
  attributes :id, :email, :username, :first_name, :last_name, :zip_code, :role, :number_of_children, :years_experience, :pay, :bio, :image_url

end
