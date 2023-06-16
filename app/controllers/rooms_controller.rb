class RoomsController < ApplicationController
  before_action :set_room, only: %i[show update destroy]

  def index
    @rooms = Room.all
    render json: @rooms
  end

  def show
    render json: @room
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      render json: { status: 'success', message: 'Room created successfully', data: @room }, status: :created
    else
      render json: { status: 'error', message: 'Room not created', data: @room.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render json: { status: 'success', message: 'Room updated successfully', data: @room }, status: :ok
    else
      render json: { status: 'error', message: 'Room not updated', data: @room.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy

    # format.json { head :no_content }

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
