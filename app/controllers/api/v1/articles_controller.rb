class Api::V1::ArticlesController < ApiController
  def create
    @article = Article.new(article_params)

    if @article.save
      render :show, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end
end
