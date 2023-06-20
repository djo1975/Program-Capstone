class RoomsController < ApplicationController
  include Apipie::DSL

  before_action :set_room, only: %i[show update destroy]

  # GET /rooms
  # Get all rooms
  #
  # @api {get} /rooms
  #
  # @return [JSON] JSON response with all rooms
  api!({
         method: 'GET',
         path: '/rooms',
         summary: 'Get all rooms',
         response: { body: { status: 'JSON', desc: 'JSON response with all rooms' } }
       })
  def index
    @rooms = Room.all
    render json: @rooms
  end

  # GET /rooms/:id
  # Get a room by ID
  #
  # @api {get} /rooms/:id
  # @param [Integer] id Room ID
  #
  # @return [JSON] JSON response with the room details
  api!({
         method: 'GET',
         path: '/rooms/:id',
         summary: 'Get a room by ID',
         parameters: [
           {
             name: 'id',
             description: 'Room ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the room details' } }
       })
  def show
    render json: @room
  end

  # POST /rooms
  # Create a new room
  #
  # @api {post} /rooms
  # @param [Hash] room Room parameters
  # @option room [String] :name Room name
  # @option room [String] :icon Room icon
  # @option room [String] :description Room description
  # @option room [Numeric] :cost_per_day Room cost per day
  #
  # @return [JSON] JSON response with the created room details
  api!({
         method: 'POST',
         path: '/rooms',
         summary: 'Create a new room',
         parameters: [
           {
             name: 'room',
             description: 'Room parameters',
             required: true,
             type: 'Hash',
             properties: {
               name: { type: 'String', desc: 'Room name' },
               icon: { type: 'String', desc: 'Room icon' },
               description: { type: 'String', desc: 'Room description' },
               cost_per_day: { type: 'Numeric', desc: 'Room cost per day' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the created room details' } }
       })
  def create
    @room = Room.new(room_params)

    if @room.save
      render json: { status: 'success', message: 'Room created successfully', data: @room }, status: :created
    else
      render json: { status: 'error', message: 'Room not created', data: @room.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rooms/:id
  # Update a room
  #
  # @api {put} /rooms/:id
  # @param [Integer] id Room ID
  # @param [Hash] room Room parameters
  # @option room [String] :name Room name
  # @option room [String] :icon Room icon
  # @option room [String] :description Room description
  # @option room [Numeric] :cost_per_day Room cost per day
  #
  # @return [JSON] JSON response with the updated room details
  api!({
         method: 'PUT',
         path: '/rooms/:id',
         summary: 'Update a room',
         parameters: [
           {
             name: 'id',
             description: 'Room ID',
             required: true,
             type: 'Integer'
           },
           {
             name: 'room',
             description: 'Room parameters',
             required: true,
             type: 'Hash',
             properties: {
               name: { type: 'String', desc: 'Room name' },
               icon: { type: 'String', desc: 'Room icon' },
               description: { type: 'String', desc: 'Room description' },
               cost_per_day: { type: 'Numeric', desc: 'Room cost per day' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the updated room details' } }
       })
  def update
    if @room.update(room_params)
      render json: { status: 'success', message: 'Room updated successfully', data: @room }, status: :ok
    else
      render json: { status: 'error', message: 'Room not updated', data: @room.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/:id
  # Delete a room
  #
  # @api {delete} /rooms/:id
  # @param [Integer] id Room ID
  #
  # @return [JSON] JSON response indicating the room has been deleted
  api!({
         method: 'DELETE',
         path: '/rooms/:id',
         summary: 'Delete a room',
         parameters: [
           {
             name: 'id',
             description: 'Room ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response indicating the room has been deleted' } }
       })
  def destroy
    @room.destroy

    render json: { status: 'success', message: 'Room deleted successfully', data: @room }, status: :ok
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :icon, :description, :cost_per_day)
  end
end
