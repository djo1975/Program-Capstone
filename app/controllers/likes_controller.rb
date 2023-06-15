# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :set_like, only: %i[show destroy]

  def index
    likes = Like.all
    render json: likes
  end

  def show
    render json: @like, serializer: LikeSerializer
  end

  def create
    like = Like.new(like_params)
    if like.save
      render json: like, status: :created
    else
      render json: like.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @like.destroy
    head :no_content
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:user_id, :comment_id)
  end
end

# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]

  def show
    render json: @comment
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :room_id, :content)
  end
end
