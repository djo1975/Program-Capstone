# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]

  # GET /comments
  # Get all comments
  #
  # @api {get} /comments
  #
  # @return [JSON] JSON response with all comments
  api!({
         method: 'GET',
         path: '/comments',
         summary: 'Get all comments',
         response: { body: { status: 'JSON', desc: 'JSON response with all comments' } }
       })
  def index
    comments = Comment.all
    render json: comments
  end

  # GET /comments/:id
  # Get a comment
  #
  # @api {get} /comments/:id
  # @param [Integer] id Comment ID
  #
  # @return [JSON] JSON response with the comment details
  api!({
         method: 'GET',
         path: '/comments/:id',
         summary: 'Get a comment',
         parameters: [
           {
             name: 'id',
             description: 'Comment ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the comment details' } }
       })
  def show
    render json: @comment
  end

  # POST /comments
  # Create a new comment
  #
  # @api {post} /comments
  # @param [Hash] comment Comment parameters
  # @option comment [Integer] :user_id User ID
  # @option comment [Integer] :vespa_id Vespa ID
  # @option comment [String] :content Comment content
  #
  # @return [JSON] JSON response with the created comment details
  api!({
         method: 'POST',
         path: '/comments',
         summary: 'Create a new comment',
         parameters: [
           {
             name: 'comment',
             description: 'Comment parameters',
             required: true,
             type: 'Hash',
             properties: {
               user_id: { type: 'Integer', desc: 'User ID' },
               vespa_id: { type: 'Integer', desc: 'Vespa ID' },
               content: { type: 'String', desc: 'Comment content' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the created comment details' } }
       })
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: { status: 'success', message: 'Comment created successfully', data: comment }, status: :created
    else
      render json: { status: 'error', message: 'Comment not created', data: comment.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/:id
  # Update a comment
  #
  # @api {put} /comments/:id
  # @param [Integer] id Comment ID
  # @param [Hash] comment Comment parameters
  # @option comment [Integer] :user_id User ID
  # @option comment [Integer] :vespa_id Vespa ID
  # @option comment [String] :content Comment content
  #
  # @return [JSON] JSON response with the updated comment details
  api!({
         method: 'PUT',
         path: '/comments/:id',
         summary: 'Update a comment',
         parameters: [
           {
             name: 'id',
             description: 'Comment ID',
             required: true,
             type: 'Integer'
           },
           {
             name: 'comment',
             description: 'Comment parameters',
             required: true,
             type: 'Hash',
             properties: {
               user_id: { type: 'Integer', desc: 'User ID' },
               vespa_id: { type: 'Integer', desc: 'Vespa ID' },
               content: { type: 'String', desc: 'Comment content' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the updated comment details' } }
       })
  def update
    if @comment.update(comment_params)
      render json: { status: 'success', message: 'Comment updated successfully', data: @comment }, status: :ok
    else
      render json: { status: 'error', message: 'Comment not updated', data: @comment.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /comments/:id
  # Delete a comment
  #
  # @api {delete} /comments/:id
  # @param [Integer] id Comment ID
  #
  # @return [JSON] JSON response with the deleted comment details
  api!({
         method: 'DELETE',
         path: '/comments/:id',
         summary: 'Delete a comment',
         parameters: [
           {
             name: 'id',
             description: 'Comment ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the deleted comment details' } }
       })
  def destroy
    @comment.destroy
    render json: { status: 'success', message: 'Comment deleted successfully', data: @comment }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:user_id, :vespa_id, :content)
  end
end
