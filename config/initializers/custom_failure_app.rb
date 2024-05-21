class CustomFailureApp < Devise::FailureApp
  def http_auth_body
    return super unless request_format == :json

    {
      status: {
        success: false,
        message: i18n_message
      }
    }.to_json

  end
end
