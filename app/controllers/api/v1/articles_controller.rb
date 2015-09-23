class Api::V1::ArticlesController < ApiController
  def create
    @article = Article.new(article_params)

    if @article.save
      render :show, status: :created
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @article.update_attributes(article_params)
      render :show, status: :ok
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end
end
