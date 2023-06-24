class VespasController < ApplicationController
  include Apipie::DSL

  before_action :set_vespa, only: %i[show update destroy]

  # GET /espas
  # Get all espas
  #
  # @api {get} /espas
  #
  # @return [JSON] JSON response with all espas
  api!({
         method: 'GET',
         path: '/espas',
         summary: 'Get all espas',
         response: { body: { status: 'JSON', desc: 'JSON response with all espas' } }
       })
  def index
    vespas = Vespa.all
    vespas_with_comments = vespas.map { |vespa| vespa.as_json.merge(comments_count: vespa.comments_count) }
    render json: vespas_with_comments
  end

  # GET /espas/:id
  # Get a vespa by ID
  #
  # @api {get} /espas/:id
  # @param [Integer] id Vespa ID
  #
  # @return [JSON] JSON response with the vespa details
  api!({
         method: 'GET',
         path: '/espas/:id',
         summary: 'Get a vespa by ID',
         parameters: [
           {
             name: 'id',
             description: 'Vespa ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the vespa details' } }
       })
  def show
    render json: @vespa
  end

  # POST /espas
  # Create a new vespa
  #
  # @api {post} /espas
  # @param [Hash] vespa Vespa parameters
  # @option vespa [String] :name Vespa name
  # @option vespa [String] :icon Vespa icon
  # @option vespa [String] :description Vespa description
  # @option vespa [Numeric] :cost_per_day Vespa cost per day
  #
  # @return [JSON] JSON response with the created vespa details
  api!({
         method: 'POST',
         path: '/espas',
         summary: 'Create a new vespa',
         parameters: [
           {
             name: 'vespa',
             description: 'Vespa parameters',
             required: true,
             type: 'Hash',
             properties: {
               name: { type: 'String', desc: 'Vespa name' },
               icon: { type: 'String', desc: 'Vespa icon' },
               description: { type: 'String', desc: 'Vespa description' },
               cost_per_day: { type: 'Numeric', desc: 'Vespa cost per day' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the created vespa details' } }
       })
  def create
    @vespa = Vespa.new(vespa_params)

    if @vespa.save
      render json: { status: 'success', message: 'Vespa created successfully', data: @vespa }, status: :created
    else
      render json: { status: 'error', message: 'Vespa not created', data: @vespa.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /espas/:id
  # Update a vespa
  #
  # @api {put} /espas/:id
  # @param [Integer] id Vespa ID
  # @param [Hash] vespa Vespa parameters
  # @option vespa [String] :name Vespa name
  # @option vespa [String] :icon Vespa icon
  # @option vespa [String] :description Vespa description
  # @option vespa [Numeric] :cost_per_day Vespa cost per day
  #
  # @return [JSON] JSON response with the updated vespa details
  api!({
         method: 'PUT',
         path: '/espas/:id',
         summary: 'Update a vespa',
         parameters: [
           {
             name: 'id',
             description: 'Vespa ID',
             required: true,
             type: 'Integer'
           },
           {
             name: 'vespa',
             description: 'Vespa parameters',
             required: true,
             type: 'Hash',
             properties: {
               name: { type: 'String', desc: 'Vespa name' },
               icon: { type: 'String', desc: 'Vespa icon' },
               description: { type: 'String', desc: 'Vespa description' },
               cost_per_day: { type: 'Numeric', desc: 'Vespa cost per day' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with the updated vespa details' } }
       })
  def update
    if @vespa.update(vespa_params)
      render json: { status: 'success', message: 'Vespa updated successfully', data: @vespa }, status: :ok
    else
      render json: { status: 'error', message: 'Vespa not updated', data: @vespa.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /espas/:id
  # Delete a vespa
  #
  # @api {delete} /espas/:id
  # @param [Integer] id Vespa ID
  #
  # @return [JSON] JSON response indicating the vespa has been deleted
  api!({
         method: 'DELETE',
         path: '/espas/:id',
         summary: 'Delete a vespa',
         parameters: [
           {
             name: 'id',
             description: 'Vespa ID',
             required: true,
             type: 'Integer'
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response indicating the vespa has been deleted' } }
       })
  def destroy
    @vespa.destroy

    render json: { status: 'success', message: 'Vespa deleted successfully', data: @vespa }, status: :ok
  end

  private

  def set_vespa
    @vespa = Vespa.find(params[:id])
  end

  def vespa_params
    params.require(:vespa).permit(:name, :icon, :description, :cost_per_day)
  end
end
