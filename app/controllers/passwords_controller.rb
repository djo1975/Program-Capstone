class PasswordsController < Devise::PasswordsController
  respond_to :json

  def create
    self.resource = resource_class.send_reset_password_instructions(params[:user])

    if successfully_sent?(resource)
      render json: { message: 'Reset password instructions sent' }
    else
      render json: { message: 'Error sending reset password instructions' }, status: :unprocessable_entity
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(params[:user])

    if resource.errors.empty?
      sign_in(resource)
      render json: { message: 'Password successfully reset' }, status: :ok
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def after_resetting_password_path_for(resource)
    new_session_path(resource)
  end
end
