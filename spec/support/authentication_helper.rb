module AuthenticationHelpers
  def authenticate_request_for(user)
    @env ||= {}
    @env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)
  end
end
