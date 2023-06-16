class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource
      sign_in(resource_name, resource)
      token = resource.generate_jwt
      resource.update(jti: token)
      render json: { message: 'Signed in successfully', user: resource, token: token }
    else
      render json: { message: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end

    def destroy
        if current_user
            sign_out(current_user)
            render json: { message: 'Signed out successfully' }, status: :ok
        else
            render json: { message: 'No active session' }, status: :unprocessable_entity
        end
    end
end
