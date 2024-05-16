class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :username, :first_name, :last_name, :zip_code, :role, :display_picture, :number_of_children, :years_experience, :pay, :bio
end
