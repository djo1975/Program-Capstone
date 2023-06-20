class ReservationsController < ApplicationController
  include Apipie::DSL

  before_action :set_reservation, only: %i[show edit update destroy]

  # GET /reservations
  # Get all reservations
  #
  # @api {get} /reservations
  #
  # @return [JSON] JSON response with all reservations
  api!({
         method: 'GET',
         path: '/reservations',
         summary: 'Get all reservations',
         response: { body: { status: 'JSON', desc: 'JSON response with all reservations' } }
       })
  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  # GET /reservations/:id
  # Get a reservation by ID
  #
  # @api {get} /reservations/:id
  # @param [Integer] id Reservation ID
  #
  # @return [JSON] JSON response with the reservation details
  api!({
         method: 'GET',
         path: '/reservations/:id',
         summary: 'Get a reservation by ID',
         parameters: [
           {
             name: 'id',
             description: 'Reservation ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the reservation details' } }
       })
  def show
    render json: @reservation
  end

  # POST /reservations
  # Create a new reservation
  #
  # @api {post} /reservations
  # @param [Hash] reservation Reservation parameters
  # @option reservation [Date] :start_date Reservation start date
  # @option reservation [Date] :end_date Reservation end date
  # @option reservation [String] :description Reservation description
  # @option reservation [Integer] :user_id User ID
  # @option reservation [Integer] :room_id Room ID
  #
  # @return [JSON] JSON response with the created reservation details
  api!({
         method: 'POST',
         path: '/reservations',
         summary: 'Create a new reservation',
         parameters: [
           {
             name: 'reservation',
             description: 'Reservation parameters',
             required: true,
             type: 'Hash',
             properties: {
               start_date: { type: 'Date', desc: 'Reservation start date' },
               end_date: { type: 'Date', desc: 'Reservation end date' },
               description: { type: 'String', desc: 'Reservation description' },
               user_id: { type: 'Integer', desc: 'User ID' },
               room_id: { type: 'Integer', desc: 'Room ID' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the created reservation details' } }
       })
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: { status: 'success', message: 'Reservation created successfully', data: @reservation }, status: :created
    else
      render json: { status: 'error', message: 'Reservation not created', data: @reservation.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/:id
  # Update a reservation
  #
  # @api {put} /reservations/:id
  # @param [Integer] id Reservation ID
  # @param [Hash] reservation Reservation parameters
  # @option reservation [Date] :start_date Reservation start date
  # @option reservation [Date] :end_date Reservation end date
  # @option reservation [String] :description Reservation description
  # @option reservation [Integer] :user_id User ID
  # @option reservation [Integer] :room_id Room ID
  #
  # @return [JSON] JSON response with the updated reservation details
  api!({
         method: 'PUT',
         path: '/reservations/:id',
         summary: 'Update a reservation',
         parameters: [
           {
             name: 'id',
             description: 'Reservation ID',
             required: true,
             type: 'Integer'
           },
           {
             name: 'reservation',
             description: 'Reservation parameters',
             required: true,
             type: 'Hash',
             properties: {
               start_date: { type: 'Date', desc: 'Reservation start date' },
               end_date: { type: 'Date', desc: 'Reservation end date' },
               description: { type: 'String', desc: 'Reservation description' },
               user_id: { type: 'Integer', desc: 'User ID' },
               room_id: { type: 'Integer', desc: 'Room ID' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the updated reservation details' } }
       })
  def update
    if @reservation.update(reservation_params)
      render json: { status: 'success', message: 'Reservation updated successfully', data: @reservation }, status: :ok
    else
      render json: { status: 'error', message: 'Reservation not updated', data: @reservation.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/:id
  # Delete a reservation
  #
  # @api {delete} /reservations/:id
  # @param [Integer] id Reservation ID
  #
  # @return [JSON] JSON response indicating the reservation has been deleted
  api!({
         method: 'DELETE',
         path: '/reservations/:id',
         summary: 'Delete a reservation',
         parameters: [
           {
             name: 'id',
             description: 'Reservation ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response indicating the reservation has been deleted' } }
       })
  def destroy
    @reservation.destroy

    render json: { status: 'success', message: 'Reservation deleted successfully', data: @reservation }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation)
      .permit(:start_date, :end_date, :description, :user_id, :room_id)
  end
end
