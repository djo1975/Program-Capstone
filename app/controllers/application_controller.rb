class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  before_action :authenticate_request

  private

  # Authenticates the request based on the Authorization header
  #
  # @api private
  def authenticate_request
    token = request.headers['Authorization']
    return render_unauthorized unless token

    @user = User.find_by(jti: token)
    render_unauthorized unless @user
  end

  # Renders an unauthorized response
  #
  # @api private
  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
