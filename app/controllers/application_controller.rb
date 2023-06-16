class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  before_action :authenticate_request

  private

  def authenticate_request
    return if (request.post? && request.path == '/users/sign_up')
    token = request.headers['Authorization']
    return render_unauthorized unless token

    @user = User.find_by(jti: token)
    render_unauthorized unless @user
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
