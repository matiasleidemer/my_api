class Api::V1::CommentsController < ApiController
  load_and_authorize_resource :article
  load_and_authorize_resource :comment, through: :article

  def index
    @comments = @article.comments
  end

  def create
    @comment = @article.comments.new(comment_params)

    if @comment.save
      render :show, status: :created
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update_attributes(comment_params)
      render :show, status: :ok
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author, :body, :article_id)
  end
end
