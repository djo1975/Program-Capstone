class SessionsController < Devise::SessionsController
  include Apipie::DSL

  respond_to :json

  # POST /users/sign_in
  # Sign in a user
  #
  # @api {post} /users/sign_in
  # @param [Hash] user User credentials
  # @option user [String] :email User's email
  # @option user [String] :password User's password
  #
  # @return [JSON] JSON response with status, message, user, and token
  api!({
         method: 'POST',
         path: '/users/sign_in',
         summary: 'Sign in a user',
         parameters: [
           {
             name: 'user',
             description: 'User credentials',
             required: true,
             type: 'Hash',
             properties: {
               email: { type: 'String', desc: "User's email" },
               password: { type: 'String', desc: "User's password" }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with status, message, user, and token' } }
       })
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource
      sign_in(resource_name, resource)
      token = resource.generate_jwt
      resource.update(jti: token)
      render json: { message: 'Signed in successfully', user: resource, token: }
    else
      render json: { message: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end

  # DELETE /users/sign_out
  # Sign out the current user
  #
  # @api {delete} /users/sign_out
  #
  # @return [JSON] JSON response with status and message
  api!({
         method: 'DELETE',
         path: '/users/sign_out',
         summary: 'Sign out the current user',
         response: { body: { status: 'JSON', desc: 'JSON response with status and message' } }
       })
  def destroy
    if current_user
      sign_out(current_user)
      render json: { message: 'Signed out successfully' }, status: :ok
    else
      render json: { message: 'No active session' }, status: :unprocessable_entity
    end
  end
end
