json.partial! 'article', article: @article
json.comments do
  json.partial! 'api/v1/comments/comment', collection: @article.comments, as: :comment
end
