class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  before_action :authenticate_request, unless: :sign_up_or_sign_in_request?

  private

  def authenticate_request
    token = request.headers['Authorization']
    return render_unauthorized unless token

    @user = User.find_by(jti: token)
    render_unauthorized unless @user
  end

  def sign_up_or_sign_in_request?
    request.path == '/users/sign_in' || request.path == '/users/sign_up'
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
  