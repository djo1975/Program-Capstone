# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]

  def index
    comments = Comment.all
    render json: comments
  end

  def show
    render json: @comment
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: { status: 'success', message: 'Comment created successfully', data: comment }, status: :created
    else
      render json: { status: 'error', message: 'Commnet not created', data: comment.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render  json: { status: 'success', message: 'Comment updated successfully', data: @comment }, status: :ok
    else
      render json: json: { status: 'error', message: 'Comment not updated', data: @comment.errors }, status: :unprocessable_entity
  end

  def destroy
    @comment.destroy
    render json: { status: 'success', message: 'Comment deleted successfully', data: @comment }, status: :ok
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :room_id, :content)
  end
end
