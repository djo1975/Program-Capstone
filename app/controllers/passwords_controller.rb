class PasswordsController < Devise::PasswordsController
  include Apipie::DSL

  respond_to :json

  # POST /users/password
  # Send reset password instructions
  #
  # @api {post} /users/password
  # @param [Hash] user User parameters
  # @option user [String] :email User's email
  #
  # @return [JSON] JSON response with status and message
  api!({
         method: 'POST',
         path: '/users/password',
         summary: 'Send reset password instructions',
         parameters: [
           {
             name: 'user',
             description: 'User parameters',
             required: true,
             type: 'Hash',
             properties: {
               email: { type: 'String', desc: "User's email" }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with status and message' } }
       })
  def create
    self.resource = resource_class.send_reset_password_instructions(params[:user])

    if successfully_sent?(resource)
      render json: { message: 'Reset password instructions sent' }
    else
      render json: { message: 'Error sending reset password instructions' }, status: :unprocessable_entity
    end
  end

  # PUT /users/password
  # Reset user's password
  #
  # @api {put} /users/password
  # @param [Hash] user User parameters
  # @option user [String] :reset_password_token Reset password token
  # @option user [String] :password New password
  # @option user [String] :password_confirmation Password confirmation
  #
  # @return [JSON] JSON response with status and message
  api!({
         method: 'PUT',
         path: '/users/password',
         summary: "Reset user's password",
         parameters: [
           {
             name: 'user',
             description: 'User parameters',
             required: true,
             type: 'Hash',
             properties: {
               reset_password_token: { type: 'String', desc: 'Reset password token' },
               password: { type: 'String', desc: 'New password' },
               password_confirmation: { type: 'String', desc: 'Password confirmation' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with status and message' } }
       })
  def update
    self.resource = resource_class.find_by(reset_password_token: params[:user][:reset_password_token])
    return unless resource&.reset_password_period_valid?

    resource.reset_password(params[:user][:password], params[:user][:password_confirmation])
    if resource.errors.empty?
      sign_in(resource_name, resource)
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
