module PathHelpers
  def articles_path(user, params = {})
    params.merge!(user_email: user.email, user_token: user.authentication_token)

    api_v1_articles_path(params)
  end

  def article_path(user, params = {})
    params.merge!(user_email: user.email, user_token: user.authentication_token)

    api_v1_article_path(params)
  end

  def comments_path(user, article, params = {})
    params.merge!(
      user_email: user.email,
      user_token: user.authentication_token,
      article_id: article.id
    )

    api_v1_article_comments_path(params)
  end

  def comment_path(user, article, params = {})
    params.merge!(
      user_email: user.email,
      user_token: user.authentication_token,
      article_id: article.id
    )

    api_v1_article_comment_path(params)
  end
end
