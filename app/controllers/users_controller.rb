class UsersController < ApplicationController
  include Apipie::DSL

  before_action :set_user, only: %i[show update destroy]

  # GET /users
  # Get all users
  #
  # @api {get} /users
  #
  # @return [JSON] JSON response with all users
  api!({
         method: 'GET',
         path: '/users',
         summary: 'Get all users',
         response: { body: { status: 'JSON', desc: 'JSON response with all users' } }
       })
  def index
    users = User.all
    render json: users
  end

  # GET /users/:id
  # Get a user by ID
  #
  # @api {get} /users/:id
  # @param [Integer] id User ID
  #
  # @return [JSON] JSON response with the user details
  api!({
         method: 'GET',
         path: '/users/:id',
         summary: 'Get a user by ID',
         parameters: [
           {
             name: 'id',
             description: 'User ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the user details' } }
       })
  def show
    render json: @user
  end

  # POST /users
  # Create a new user
  #
  # @api {post} /users
  # @param [Hash] user User parameters
  # @option user [String] :username Username
  #
  # @return [JSON] JSON response with the created user details
  api!({
         method: 'POST',
         path: '/users',
         summary: 'Create a new user',
         parameters: [
           {
             name: 'user',
             description: 'User parameters',
             required: true,
             type: 'Hash',
             properties: {
               username: { type: 'String', desc: 'Username' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the created user details' } }
       })
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/:id
  # Update a user
  #
  # @api {put} /users/:id
  # @param [Integer] id User ID
  # @param [Hash] user User parameters
  # @option user [String] :username Username
  #
  # @return [JSON] JSON response with the updated user details
  api!({
         method: 'PUT',
         path: '/users/:id',
         summary: 'Update a user',
         parameters: [
           {
             name: 'id',
             description: 'User ID',
             required: true,
             type: 'Integer'
           },
           {
             name: 'user',
             description: 'User parameters',
             required: true,
             type: 'Hash',
             properties: {
               username: { type: 'String', desc: 'Username' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the updated user details' } }
       })
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  # Delete a user
  #
  # @api {delete} /users/:id
  # @param [Integer] id User ID
  #
  # @return [JSON] JSON response indicating the user has been deleted
  api!({
         method: 'DELETE',
         path: '/users/:id',
         summary: 'Delete a user',
         parameters: [
           {
             name: 'id',
             description: 'User ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response indicating the user has been deleted' } }
       })
  def destroy
    Like.where(comment_id: Comment.where(user_id: @user.id).pluck(:id)).delete_all
    Comment.where(user_id: @user.id).delete_all
    Reservation.where(user_id: @user.id).delete_all
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username)
  end
end
