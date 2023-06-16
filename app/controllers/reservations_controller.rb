class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show edit update destroy]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  # GET /reservations/1 or /reservations/1.json
  def show; 
    render json: @reservation
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit; end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    # @reservation = Reservation.new(start_date: params[:start_date], end_date: params[:end_date], description: params[:description], user_id: params[:user_id], room_id: params[:room_id])
      if @reservation.save
        # format.html { redirect_to reservation_url(@reservation), notice: 'Reservation was successfully created.' }
        # format.json { render :@reservation, status: :created}
        # render json: @reservation
        # render json: @reservation, status: :created, location: @reservation
        render json: { status: "success", message: "Reservation created successfully", data: @reservation }, status: :created
      else
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @reservation.errors, status: :unprocessable_entity }
        render json: { status: "error", message: "Reservation not created", data: @reservation.errors }, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
      # @reservation = Reservation.find(params[:id])
      if @reservation.update(reservation_params)
        # format.json { render :show, status: :ok, location: @reservation }
        render json: { status: "success", message: "Reservation updated successfully", data: @reservation }, status: :ok
      else
        # format.json { render json: @reservation.errors, status: :unprocessable_entity }
        render json: { status: "error", message: "Reservation not updated", data: @reservation.errors }, status: :unprocessable_entity
      end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

   
      # format.json { head :no_content }

      render json: { status: "success", message: "Reservation deleted successfully", data: @reservation }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation)
          .permit(:start_date, :end_date, :description,:user_id, :room_id)
  end
end
