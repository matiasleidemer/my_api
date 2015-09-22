module PathHelpers
  def articles_path(user, params = {})
    params.merge!(user_email: user.email, user_token: user.authentication_token)

    api_v1_articles_path(params)
  end
end
