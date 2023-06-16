# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :set_like, only: %i[show destroy]

  def index
    likes = Like.all
    render json: likes
  end

  def show
    render json: @like
  end

  def create
    like = Like.new(like_params)
    if like.save
      render json: { status: 'success', message: 'Like created successfully', data: like }, status: :created
    else
      render json: { status: 'error', message: 'Like not created', data: like.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @like.destroy
    render json: { status: 'success', message: 'Like deleted successfully', data: @like }, status: :ok
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:user_id, :comment_id)
  end
end
