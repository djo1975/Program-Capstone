# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  before_action :set_like, only: %i[show destroy]

  # GET /likes
  # Get all likes
  #
  # @api {get} /likes
  #
  # @return [JSON] JSON response with all likes
  api!({
         method: 'GET',
         path: '/likes',
         summary: 'Get all likes',
         response: { body: { status: 'JSON', desc: 'JSON response with all likes' } }
       })
  def index
    likes = Like.all
    render json: likes
  end

  # GET /likes/:id
  # Get a like
  #
  # @api {get} /likes/:id
  # @param [Integer] id Like ID
  #
  # @return [JSON] JSON response with the like details
  api!({
         method: 'GET',
         path: '/likes/:id',
         summary: 'Get a like',
         parameters: [
           {
             name: 'id',
             description: 'Like ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the like details' } }
       })
  def show
    render json: @like
  end

  # POST /likes
  # Create a new like
  #
  # @api {post} /likes
  # @param [Hash] like Like parameters
  # @option like [Integer] :user_id User ID
  # @option like [Integer] :comment_id Comment ID
  #
  # @return [JSON] JSON response with the created like details
  api!({
         method: 'POST',
         path: '/likes',
         summary: 'Create a new like',
         parameters: [
           {
             name: 'like',
             description: 'Like parameters',
             required: true,
             type: 'Hash',
             properties: {
               user_id: { type: 'Integer', desc: 'User ID' },
               comment_id: { type: 'Integer', desc: 'Comment ID' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the created like details' } }
       })
  def create
    like = Like.new(like_params)
    if like.save
      render json: { status: 'success', message: 'Like created successfully', data: like }, status: :created
    else
      render json: { status: 'error', message: 'Like not created', data: like.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /likes/:id
  # Delete a like
  #
  # @api {delete} /likes/:id
  # @param [Integer] id Like ID
  #
  # @return [JSON] JSON response indicating the like has been deleted
  api!({
         method: 'DELETE',
         path: '/likes/:id',
         summary: 'Delete a like',
         parameters: [
           {
             name: 'id',
             description: 'Like ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response indicating the like has been deleted' } }
       })
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
